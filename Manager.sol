pragma solidity 0.5.1;
import "./Course.sol";

contract Manager {
    //Address of the school administrator
    address admin;
    
    mapping (address => int) student;
    mapping (address => bool) isStudent;
    mapping (int => bool) isCourse;
    mapping (int => Course) course;
    
    int rollCount = 19111000;
    
    //modifier schoolAdminOnly
    modifier schoolAdminOnly(){
        require(msg.sender == admin);
        _;
    }
    
    //modifier validSstudentOnly
    modifier validSstudentOnly(){
        require(isStudent[msg.sender]);
        _;
    }
    
    //modifier validCourseOnly
    modifier validCourseOnly(int courseNo){
        require(isCourse[courseNo]);
        _;
    }
    

    //Constructor
    constructor()  public payable{
        //initializing the address of the admin
        admin = msg.sender;
    }
    
    
    function kill() public schoolAdminOnly {
        //The admin has the right to kill the contract at any time.
        //Take care that no one else is able to kill the contract
        if(msg.sender == admin) selfdestruct(address(uint160(admin)));
    }
    
    function addStudent() public{
        //Anyone on the network can become a student if not one already
        if(!isStudent[msg.sender]){
            rollCount += 1;
            //Remember to assign the new student a unique roll number
            student[msg.sender] = rollCount;
            isStudent[msg.sender] = true;
        }
    }
    
    function addCourse(int courseNo, address instructor) public schoolAdminOnly {
	//Add a new course with course number as courseNo, and instructor at address instructor
    //Note that only the admin can add a new course. Also, don't create a new course if course already exists
        if(!isCourse[courseNo]){
            course[courseNo] = new Course(courseNo,instructor,admin);
            isCourse[courseNo] = true;
        }
    }
    
    function regCourse(int courseNo) public validSstudentOnly validCourseOnly(courseNo){
        //Register the student in the course if he is a student on roll and the courseNo is valid
        course[courseNo].enroll(student[msg.sender]);
    }
    
    
    function getMyMarks(int courseNo) public  validSstudentOnly validCourseOnly(courseNo) view returns(int, int, int)  {
        //Check the courseNo for validity
        //Should only work for valid students of that course
	    //Returns a tuple (midsem, endsem, attendance)
	    //student[msg.sender];
	    //course[courseNo];
	    return (course[courseNo].getMidsemMarks(student[msg.sender]),course[courseNo].getEndsemMarks(student[msg.sender]),course[courseNo].getAttendance(student[msg.sender]));
    }
    
    function getMyRollNo() public validSstudentOnly view returns(int) {
        //Utility function to help a student if he/she forgets the roll number
        //Should only work for valid students
        //Returns roll number as int
        return student[msg.sender];
    }
    
}

