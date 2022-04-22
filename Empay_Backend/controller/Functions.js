
const e = require('express');
const db = require('../config/mysql');

module.exports.newEmployee =  function(req,res){
    console.log(req.body.name);
    let newEmployeeSql = "INSERT INTO dbms_project.employeedetails(Name, Dept_Name, Job_desc, Salary) VALUES ('"+req.body.name+"','"+ req.body.dept_name+"','"+req.body.Job_Des+"','"+req.body.Salary+"');";
    console.log(newEmployeeSql);
    db.query(newEmployeeSql , function(err,result){
        if(err){
            console.log('Error in newEmployeeSQL',err);
        }
        else{
            console.log('newEmployee created successfully');
        }
    });
    return res.status(200).json({
        message: "New Employee Added Success"
    });
}

module.exports.DepartmentDetails = function(req,res){
    let DepartmentDetailsSql = "Select * FROM employeedetails WHERE Dept_Name = '"+req.body.dept_name+"';";
    db.query(DepartmentDetailsSql,function(err,result){
        if(err){
            console.log('Error in fetching the DepartmentDetails',err);
        }
        return res.status(200).json({
            message: "Data provided below",
            data: result
        });
    })
}

module.exports.updateSalary = function(req,res){
    let updateSalarySql = "UPDATE employeedetails SET Salary = '"+req.body.Salary+ "'WHERE id = '"+req.body.id+"'; ";
    db.query(updateSalarySql,function(err,result){
        if(err){
            console.log('Error is updating salary',err);
        }
        else{
            console.log('Updated Salary Success');
        }
    });
    return res.status(200).json({
        message : " Updating Completed"
    });
}
module.exports.updateDepartment = function(req,res){
    let updateDepartmentSql = "UPDATE employeedetails SET Dept_Name = '" + req.body.dept_name + "'WHERE id = '" + req.body.id + "'; ";
    db.query(updateDepartmentSql, function (err, result) {
        if (err) {
            console.log('Error in updating Department', err);
        }
        else {
            console.log('Updated Department Success');
        }
    });
    return res.status(200).json({
        message: " Updating Completed"
    });
}

module.exports.EmployeeDetails = function(req,res){
    let EmpolyeeDetailsSql = 'SELECT * FROM employeedetails';
    db.query(EmpolyeeDetailsSql,function(err,result){
        if(err){
            console.log('Error is fetching the data');
        }
        else{
            console.log('Employee Data Fetched Success');
        }
        return res.status(200).json({
            message: "Data provided below",
            data: result
        });
    });
    
}

module.exports.createDB = function (req, res) {
    let sql = 'CREATE DATABASE dbms_project';
    db.query(sql, function (err, result) {
        if (err) {
            return console.log('Error while creating database');
        }
        else {
            console.log('Database created successfully',result);
        }
    });
    return res.status(200).json({
        message: "DB created"
    });
}

module.exports.createTable = function(req,res){
    let EmployeeTableSql = "CREATE TABLE dbms_project.employeedetails(id INT NOT NULL AUTO_INCREMENT,Name VARCHAR(45) NOT NULL, Dept_Name VARCHAR(45) NOT NULL,Job_desc VARCHAR(45) NOT NULL ,Salary INT NOT NULL,PRIMARY KEY(id));" ;
    db.query(EmployeeTableSql , function(err,result){
        if(err){
            return console.log('Error creating employee table');
        }
        else{
            console.log('Employee Table created');
        }
        
    });
    return res.send('<html>ETS done!!!</html>');
}

module.exports.deleteEmployee = function(req,res){
    let deleteEmployee = "DELETE FROM employeedetails WHERE id = "+req.body.id+";";
    db.query(deleteEmployee,function(err,result){
        if(err){
            return res.status(200).json({
                message:"Error while deletion"
            });
        }
        else{
            return res.status(200).json({
                message:"Deleted successfully"
            });
        }
    })
}
