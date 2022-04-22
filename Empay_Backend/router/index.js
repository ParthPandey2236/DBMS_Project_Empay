const express = require('express');

const router = express.Router();
const Controller = require('../controller/Functions');


router.post('/updateSalary',Controller.updateSalary);

router.post('/updateDepart',Controller.updateDepartment);

router.post('/newEmployee' , Controller.newEmployee);

router.post('/deleteEmployee',Controller.deleteEmployee);

router.get('/departmentDetails', Controller.DepartmentDetails);

router.get('/EmployeeDetails', Controller.EmployeeDetails);

router.get('/createDB',Controller.createDB);

router.get('/createTable', Controller.createTable);



router.get('/', function(req,res){
    return res.send('<html>Running!!!</html>');
});

module.exports = router;