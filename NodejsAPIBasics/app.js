const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const nodemailer = require('nodemailer');
const cors = require('cors');

const app = express();
const port = 5000;
const localhost = '192.168.43.152';

mongoose.connect('mongodb://127.0.0.1:27017/EVoting');

const voterSchema = new mongoose.Schema({
  First_Name: {
    type:String,
    // required:true,
  },
  Last_Name: String,
  Cnic: { type: String, unique: true },
  Phone_No: String,
  E_Mail: String,
  Password: String,
  img:String,
});

const candidateSchema = new mongoose.Schema({
  First_Name: {
    type:String,
    // required:true,
  },
  Last_Name: String,
  Cnic: { type: String, unique: true },
  Phone_No: String,
  E_Mail: String,
  Password: String,
  img:String,
});

const adminSchema = new mongoose.Schema({
  First_Name: {
    type:String,
  },
  Last_Name: String,
  Cnic: { type: String, unique: true },
  Phone_No: String,
  E_Mail: String,
  Password: String,
});

const election = new mongoose.Schema({
  type: {type:String, required:true, unique: false},
  startdate: {type:String, required:true, unique: false},
  enddate: {type:String, required:true, unique: false},
  users: [],
  voters: [],
});

const VoterModel = mongoose.model('Voters', voterSchema);
const CandidateModel = mongoose.model('Candidates', candidateSchema);
const AdminModel = mongoose.model('Admins', adminSchema);
const electionModel = mongoose.model('election', election);


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

// get one candidate
app.post('/getonecandidate', async (req, res) => {
  try {
    const { Cnic } = req.body;
    const electiondata = await CandidateModel.findOne({Cnic:Cnic});
    const filteredData = Object.assign({}, electiondata.toObject());
    if (filteredData.relatedCandidate) {
      delete filteredData.relatedCandidate;
    }
    res.status(200).json(filteredData);
  } catch (error) {
    console.error(error);
    res.status(500).json({});
  }
});

// update password candidate
app.post('/updatepasswordcandidate', async (req, res) => {
  try {
    const { Cnic, Password } = req.body;
    await CandidateModel.findOneAndUpdate({Cnic:Cnic},{$set:{Password:Password}});
    res.status(200).json(true);
  } catch (error) {
    console.error(error);
    res.status(500).json(false);
  }
});

// get one voters
app.post('/getonevoter', async (req, res) => {
  try {
    const { Cnic } = req.body;
    const electiondata = await VoterModel.findOne({Cnic:Cnic});
    const filteredData = Object.assign({}, electiondata.toObject());
    if (filteredData.relatedCandidate) {
      delete filteredData.relatedCandidate;
    }
    res.status(200).json(filteredData);
  } catch (error) {
    console.error(error);
    res.status(500).json({});
  }
});

// update password voter
app.post('/updatepasswordvoter', async (req, res) => {
  try {
    const { Cnic, Password } = req.body;
    await VoterModel.findOneAndUpdate({Cnic:Cnic},{$set:{Password:Password}});
    res.status(200).json(true);
  } catch (error) {
    console.error(error);
    res.status(500).json(false);
  }
});

// send otp
app.post('/sendotp', async (req, res) => {
    const { number1, number2, email, number } = req.body;
    const transporter = nodemailer.createTransport({
      host: "smtp-relay.brevo.com",
      port: 587,
      auth: {
        user: "bscs2012287@szabist.pk",
        pass: "S1Bm7pD0srfIHE3J",
      },
    });
    try{
      await transporter.sendMail({
        from: 'admin@payrozgar.com',
        to: email,
        subject: "E voting OTP", 
        text: "Welcome To Evoting your otp is : "+number1+"your second password otp is : "+number2,
        html: "<h1>Welcome To Evoting</h1><br><p>your otp is : "+number1+"</p><br><p>your second password otp is : "+number2+"</p>"
      });
      res.status(200).send({"data": "send mail", "status": true});
    } catch(e){
      res.status(200).send({"data": "fail to send mail", "status": false});
    }
});


//find canidate by id
app.post('/findcandidatebyid', async (req, res) => {
  try {
    const { id } = req.body;
    const electiondata = await CandidateModel.findById(id);
    const filteredData = Object.assign({}, electiondata.toObject());
    if (filteredData.relatedCandidate) {
      delete filteredData.relatedCandidate;
    }
    res.status(200).json(filteredData);
  } catch (error) {
    console.error(error);
    res.status(500).json({});
  }
});


// insert election
app.post('/createelction', async (req, res) => {
  try {
    const { type, startdate, enddate } = req.body;
    const electiondata = new electionModel({type, startdate, enddate});
    await electiondata.save();
    res.status(200).json({ status:true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false });
  }
});

// get all elections
app.post('/getelection', async (req, res) => {
  try {
    const allelection = await electionModel.find();
    res.json(allelection);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// register candidate to the election
app.post('/registercandidatetoelection', async (req, res) => {
  try {
    const { data, id } = req.body;
    const electiondata = await electionModel.findById(id); // Use await
    if (!electiondata) {
      return res.status(404).json({ status: false });
    }
    electiondata.users.push(data);
    await electionModel.findByIdAndUpdate(id, { $set: { users: electiondata.users } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

app.post('/deletecandidatetoelection', async (req, res) => {
  try {
    const { data, id } = req.body;
    const electiondata = await electionModel.findById(id); // Use await
    for (let i = 0; i < electiondata.users.length; i++) {
      if (electiondata.users[i].uid == data) {
        electiondata.users.splice(i, 1);
        break;
      }
    }
    await electionModel.findByIdAndUpdate(id, { $set: { users: electiondata.users } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

// cast vote
app.post('/castvote', async (req, res) => {
  try {
    const { uid,id,cid } = req.body;
    const electiondata = await electionModel.findById(id);
    if (!electiondata) {
      return res.status(404).json({ status: false });
    }
    electiondata.voters.push(uid);
    electiondata.users.forEach((item) => {
      if (item.uid == cid) {
        item.vote += 1;
      }
    });
    await electionModel.findByIdAndUpdate(id, 
      { $set: { voters: electiondata.voters, users: electiondata.users } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.error(error);
    res.status(500).json({status: false});
  }
});

// update status list 
app.post('/updatestatuslist', async (req, res) => {
  try {
    const { data, id } = req.body;
    await electionModel.findByIdAndUpdate(id, { $set: { users: data } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

// update voter images
app.post('/updatevoterimg', async (req, res) => {
  try {
    const { img, id } = req.body;
    await VoterModel.findByIdAndUpdate(id, { $set: { img: img } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

// update voter images
app.post('/updatecandiateimg', async (req, res) => {
  try {
    const { img, id } = req.body;
    await CandidateModel.findByIdAndUpdate(id, { $set: { img: img } });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

// delete candiate
app.post('/deletecandiate', async (req, res) => {
  try {
    const { Cnic } = req.body;
    await CandidateModel.findOneAndDelete({ Cnic: Cnic });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

// delete voter
app.post('/deletevoter', async (req, res) => {
  try {
    const { Cnic } = req.body;
    await VoterModel.findOneAndDelete({ Cnic: Cnic });
    res.status(200).json({ status: true });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});


app.post('/voterimage', async (req, res) => {
  try {
    const { Cnic } = req.body;
    var d = await VoterModel.findOne({ Cnic: Cnic });
    res.status(200).json({ data: d });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});

app.post('/candidateimage', async (req, res) => {
  try {
    const { Cnic } = req.body;
    var d = await CandidateModel.findOne({ Cnic: Cnic });
    res.status(200).json({ data: d });
  } catch (error) {
    console.log(error);
    res.status(500).json({ status: false });
  }
});





// Endpoint to insert voter data
app.post('/api/insertVoter', async (req, res) => {
  try {
    const { First_Name, Last_Name, Cnic, Phone_No, E_Mail, Password, img } = req.body;

    // Check if the provided CNIC already exists in the database
    const existingVoter = await VoterModel.findOne({ Cnic });

    if (existingVoter) {
      return res.status(400).json({ message: 'CNIC already exists' });
    }
    // Create a new voter document using the VoterModel
    const newVoter = new VoterModel({
      First_Name,
      Last_Name,
      Cnic,
      Phone_No,
      E_Mail,
      Password,
      img,
    });

    // Save the document to the database
    await newVoter.save();

    res.status(201).json({ message: 'Voter data inserted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint to insert candidate data
app.post('/api/insertCandidate', async (req, res) => {
  try {
    const { First_Name, Last_Name, Cnic, Phone_No, E_Mail, Password , img } = req.body;

    // Check if the provided CNIC already exists in the database
    const existingCandidate = await CandidateModel.findOne({ Cnic });

    if (existingCandidate) {
      return res.status(400).json({ message: 'CNIC already exists' });
    }

    // Create a new candidate document using the VoterModel
    const newCandidate = new CandidateModel({
      First_Name,
      Last_Name,
      Cnic,
      Phone_No,
      E_Mail,
      Password,
      img
    });

    // Save the document to the database
    await newCandidate.save();

    res.status(201).json({ message: 'Voter data inserted successfully' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint to insert admin data
app.post('/api/insertAdmin', async (req, res) => {
  try {
    const { First_Name, Last_Name, Cnic, Phone_No, E_Mail, Password } = req.body;

    // Check if the provided CNIC already exists in the database
    const existingAdmin = await AdminModel.findOne({ Cnic });

    if (existingAdmin) {
      return res.status(400).json({ message: 'CNIC already exists' });
    }

    // Create a new admin document using the VoterModel
    const newAdmin = new AdminModel({
      First_Name,
      Last_Name,
      Cnic,
      Phone_No,
      E_Mail,
      Password,
    });

    // Save the document to the database
    await newAdmin.save();

    res.status(201).json({ message: 'Voter data inserted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint to delete voter data by CNIC
app.delete('/api/deleteVoter/:cnic', async (req, res) => {
    try {
      const cnic = req.params.cnic;
  
      // Check if the provided CNIC exists in the database
      const existingVoter = await VoterModel.findOne({ Cnic: cnic });
  
      if (!existingVoter) {
        return res.status(404).json({ message: 'Voter not found with the provided CNIC' });
      }
  
      // Delete the voter document by CNIC
      await VoterModel.findOneAndDelete({ Cnic: cnic });
  
      res.json({ message: 'Voter data deleted successfully' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

// Endpoint to delete admin data by CNIC
app.delete('/api/deleteAdmin/:cnic', async (req, res) => {
  try {
    const cnic = req.params.cnic;

    // Check if the provided CNIC exists in the database
    const existingAdmin = await AdminModel.findOne({ Cnic: cnic });

    if (!existingAdmin) {
      return res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }

    // Delete the admin document by CNIC
    await AdminModel.findOneAndDelete({ Cnic: cnic });

    res.json({ message: 'Voter data deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint to delete candidate data by CNIC
app.delete('/api/deleteCandidate/:cnic', async (req, res) => {
  try {
    const cnic = req.params.cnic;

    // Check if the provided CNIC exists in the database
    const existingCandidate = await CandidateModel.findOne({ Cnic: cnic });

    if (!existingCandidate) {
      return res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }

    // Delete the candidate document by CNIC
    await CandidateModel.findOneAndDelete({ Cnic: cnic });

    res.json({ message: 'Voter data deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

  // Endpoint to get all voter data users
app.get('/api/getAllVoters', async (req, res) => {
    try {
      const allVoters = await VoterModel.find({}, { _id: 0, __v: 0}); // Exclude _id and __v
  
      res.json(allVoters);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // Endpoint to get all voter data admins
  app.get('/api/getAllAdmins', async (req, res) => {
    try {
      const allAdmins = await AdminModel.find({}, { _id: 0, __v: 0}); // Exclude _id and __v
  
      res.json(allAdmins);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // Endpoint to get all voter data candidates
  app.get('/api/getAllCandidates', async (req, res) => {
    try {
      const allCandidates = await CandidateModel.find({}, { _id: 0, __v: 0}); // Exclude _id and __v
  
      res.json(allCandidates);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

// Endpoint for user login
app.post('/api/loginVoters', async (req, res) => {
  try {
      const { Cnic, Password } = req.body;
      console.log(req.body);
      // Find a voter with the provided credentials
      const voter = await VoterModel.findOne({ $or: [{Cnic: Cnic,Password: Password }] });
      
      console.log(voter);
    if (voter) {

      res.json({ message: 'Login successful', voter });
    } else {
      res.status(401).json({ message: 'Invalid credentials' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for candidate login
app.post('/api/loginCandidates', async (req, res) => {
  try {
    const { Cnic, Password } = req.body;
    console.log(req.body);
    // Find a voter with the provided credentials
    const voter = await CandidateModel.findOne({ $or: [{Cnic: Cnic,Password: Password }] });
    console.log(voter);
  if (voter) {
    res.json({ message: 'Login successful', voter });
  } else {
    res.status(401).json({ message: 'Invalid credentials' });
  }
} catch (error) {
  res.status(500).json({ error: error.message });
}
});

// Endpoint for admin login
app.post('/api/loginAdmins', async (req, res) => {
  try {
    const { Cnic, E_Mail, Password } = req.body;
    console.log(req.body);
    // Find a voter with the provided credentials
    const voter = await AdminModel.findOne({ $or: [{Cnic: Cnic,Password: Password,E_Mail: E_Mail }] });
    
    console.log(voter);
  if (voter) {

    res.json({ message: 'Login successful', voter });
  } else {
    res.status(401).json({ message: 'Invalid credentials' });
  }
} catch (error) {
  res.status(500).json({ error: error.message });
}
});

// Endpoint for updating Phone_No
app.put('/api/updatePhoneNoVoter', async (req, res) => {
  try {
    const { cnic, newPhoneNo } = req.body;
    console.log(cnic);
    // Update the Phone_No in the database
    const result = await VoterModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } },{new:true});
    //const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } });
    console.log(result.Phone_No);
    if (result.$isEmpty) {
      res.json({ message: 'Phone_No updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put('/api/updateEMailVoter', async (req, res) => {
  try {
    const { cnic, newEMail } = req.body;
    console.log(cnic);
    // Update the E-Mail in the database
    const result = await VoterModel.findOneAndUpdate({ Cnic: cnic }, { $set: { E_Mail: newEMail } },{new:true});

    console.log(result.E_Mail);
    if (result.$isEmpty) {
      res.json({ message: 'E-Mail updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating First_Name
app.put('/api/updateFirstNameVoter', async (req, res) => {
  try {
    const { cnic, newFirstName } = req.body;
    console.log(cnic);
    // Update the First_Name in the database
    const result = await VoterModel.findOneAndUpdate({ Cnic: cnic }, { $set: { First_Name: newFirstName } },{new:true});
    console.log(result.First_Name);
    
    if (result.$isEmpty) {
      res.json({ message: 'First_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating Last_Name
app.put('/api/updateLastNameVoter', async (req, res) => {
  try {
    const { cnic, newLastName } = req.body;

    // Update the Last_Name in the database
    const result = await VoterModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Last_Name: newLastName } },{new:true});
    
    // const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Last_Name: newLastName } });
    console.log(result.Last_Name);

    if (result.$isEmpty) {
      res.json({ message: 'Last_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Voter not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating Phone_No
app.put('/api/updatePhoneNoAdmin', async (req, res) => {
  try {
    const { cnic, newPhoneNo } = req.body;
    console.log(cnic);
    // Update the Phone_No in the database
    const result = await AdminModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } },{new:true});
    //const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } });
    console.log(result.Phone_No);
    if (result.$isEmpty) {
      res.json({ message: 'Phone_No updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Admin not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put('/api/updateEMailAdmin', async (req, res) => {
  try {
    const { cnic, newEMail } = req.body;
    console.log(cnic);
    // Update the E-Mail in the database
    const result = await AdminModel.findOneAndUpdate({ Cnic: cnic }, { $set: { E_Mail: newEMail } },{new:true});

    console.log(result.E_Mail);
    if (result.$isEmpty) {
      res.json({ message: 'E-Mail updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Admin not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating First_Name
app.put('/api/updateFirstNameAdmin', async (req, res) => {
  try {
    const { cnic, newFirstName } = req.body;
    console.log(cnic);
    // Update the First_Name in the database
    const result = await AdminModel.findOneAndUpdate({ Cnic: cnic }, { $set: { First_Name: newFirstName } },{new:true});
    console.log(result.First_Name);
    
    if (result.$isEmpty) {
      res.json({ message: 'First_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Admin not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating Last_Name
app.put('/api/updateLastNameAdmin', async (req, res) => {
  try {
    const { cnic, newLastName } = req.body;

    // Update the Last_Name in the database
    const result = await AdminModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Last_Name: newLastName } },{new:true});
    
    // const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Last_Name: newLastName } });
    console.log(result.Last_Name);

    if (result.$isEmpty) {
      res.json({ message: 'Last_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Admin not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating Phone_No
app.put('/api/updatePhoneNoCandidate', async (req, res) => {
  try {
    const { cnic, newPhoneNo } = req.body;
    console.log(cnic);
    // Update the Phone_No in the database
    const result = await CandidateModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } },{new:true});
    //const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Phone_No: newPhoneNo } });
    console.log(result.Phone_No);
    if (result.$isEmpty) {
      res.json({ message: 'Phone_No updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Candidate not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put('/api/updateEMailCandidate', async (req, res) => {
  try {
    const { cnic, newEMail } = req.body;
    console.log(cnic);
    // Update the E-Mail in the database
    const result = await CandidateModel.findOneAndUpdate({ Cnic: cnic }, { $set: { E_Mail: newEMail } },{new:true});

    console.log(result.E_Mail);
    if (result.$isEmpty) {
      res.json({ message: 'E-Mail updated successfully' ,result});
    } else {
      res.status(404).json({ message: 'Candidate not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating First_Name
app.put('/api/updateFirstNameCandidate', async (req, res) => {
  try {
    const { cnic, newFirstName } = req.body;
    console.log(cnic);
    // Update the First_Name in the database
    const result = await CandidateModel.findOneAndUpdate({ Cnic: cnic }, { $set: { First_Name: newFirstName } },{new:true});
    console.log(result.First_Name);
    
    if (result.$isEmpty) {
      res.json({ message: 'First_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Candidate not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Endpoint for updating Last_Name
app.put('/api/updateLastNameCandidate', async (req, res) => {
  try {
    const { cnic, newLastName } = req.body;

    // Update the Last_Name in the database
    const result = await CandidateModel.findOneAndUpdate({ Cnic: cnic }, { $set: { Last_Name: newLastName } },{new:true});
    
    // const result = await VoterModel.updateOne({ Cnic: cnic }, { $set: { Last_Name: newLastName } });
    console.log(result.Last_Name);

    if (result.$isEmpty) {
      res.json({ message: 'Last_Name updated successfully' , result});
    } else {
      res.status(404).json({ message: 'Candidate not found with the provided CNIC' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


app.get('/',(req,res)=>{
  res.send('Hello World !!!!!')
})

app.listen(port,localhost,()=>{
  console.log("Server Listening on Port http://localhost:" + port);})