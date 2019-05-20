# Distributed-Course-Management-System-in-Etherium
Designed and developed a secure blockchain based distributed online  Course Management System, assigned privileges to users and implemented authorizations accordingly

You are a school administrator and you want to put the course registration and grades
management on the blockchain.
There are three main parties (create different addresses for them) –


The School Administrator – your main account that will be used for deploying
contracts on the chain. It also has the privilege to kill the deployed contracts (you
should always have this option as a privileged option if you find a bug in the
contract later). Also, only the school admin can add new courses.
Instructor(s) – Each Course has an associated instructor. It has privileges to
upload the midsem, endsem marks and also mark the attendance of the student.
Students(s) – Anyone on the network can become a student. They can register
for any course that is being offered and can view their marks.
For this you will create two contracts according to the given specifications –
 Manager Contract – main contract created by the school administrator. Used for
adding courses. Also serves as endpoint for students to register for courses, view
their grades, etc.
o Variables
 admin – address of the school administrator
 student – mapping from address to roll number of students
 isStudent – whether an address is a student or not
 course – mapping from course number to course contract
instance
 isCourse – whether a course number is valid or not
 rollCount – starting number for roll numbers
o Methods
 Constructor – initialize the admin address
 kill() – kill the contract. Can be called only by the school
administrator only
 addStudent() – function that can be called by anyone on the
chain to become a student in the school. Check if the address is not
already a student.
 addCourse(int num, address i) – add a new course with
course number as num and instructor at address i
 regCourse(int cnum) – register a valid student in a valid course
with course number cnum
 getMyMarks() – used by valid students to get marks (int
midsem, int endsem. int attendance)
 getMyRollNo() – utility to be used by a valid student to get
his/her roll number.
 Course Contract – every course has an associated course contract. A contract is
deployed for every course on the blockchain by the Manager Contract.
o Variables
 admin – address of the school administrator
 managerContract – address of the manager contract
 instructor – address of the course instructor
 courseNo – integer course number
 struct Marks – struct to store midsem, endsem marks and
attendance count
 student – mapping from rollNo to marksisEnrolled – whether student with a roll number is enrolled in a
course or not
o Methods
 constructor – initialize the addresses
 kill – kill the contract. Can be called only by the school
administrator only
 enroll(int rn) – can be called by the Manager Contract only.
Registers the student if not in the course.
 markAttendance(int rn) – increase attendance of student with
roll number rn by 1. Can only be used by instructor
 addMidSemMarks(int rn, int marks) – Can only be called by
the instructor. Uploads midsem marks of students with roll
number rn
 addEndSemMarks(int rn, int marks) – Can only be called by
the instructor. Uploads endsem marks of students with roll
number rn
 getMidsemMarks(int rn) – Can only be called by Manager
Contract. Return midsem marks of student with roll number rn
 getEndsemMarks(int rn) – Can only be called by Manager
Contract. Return endsem marks of student with roll number rn
 getAttendance(int rn) – Can only be called by Manager
Contract. Return attendance marks of student with roll number rn
 isEnroll(int rn) – returns true if roll number rn is enrolled in
the course. False otherwise. Can be accessed by anyone.
