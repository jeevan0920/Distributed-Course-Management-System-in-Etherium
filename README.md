# Distributed-Course-Management-System-in-Etherium
Designed and developed a secure blockchain based distributed online  Course Management System, assigned privileges to users and implemented authorizations accordingly


You are a school administrator and you want to put the course registration and grades
management on the blockchain.

There are three main parties (create different addresses for them) –

The School Administrator – your main account that will be used for deploying
contracts on the chain. It also has the privilege to kill the deployed contracts (you
should always have this option as a privileged option if you find a bug in the
contract later). Also, only the school admin can add new courses.

Instructor(s) – Each Course has an associated instructor. It has privileges to
upload the midsem, endsem marks and also mark the attendance of the student.

Students(s) – Anyone on the network can become a student. They can register
for any course that is being offered and can view their marks.

For this you I created two contracts according to the given specifications –
1. Manager Contract – main contract created by the school administrator. Used for
adding courses. Also serves as endpoint for students to register for courses, view
their grades, etc.

2. Course Contract – every course has an associated course contract. A contract is
deployed for every course on the blockchain by the Manager Contract.
