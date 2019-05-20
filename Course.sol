pragma solidity 0.5.1;

contract Course {
    
    address admin;
    address ManagerContract;
    address instructor;
    int courseNo;
    
    struct Marks{
        int midsem;
        int endsem;
        int attendance;
    }
    
    mapping (int => Marks) student;
    mapping (int => bool) isEnrolled;
    
    
    //modifier schoolAdminOnly
    modifier schoolAdminOnly(){
        require(msg.sender == admin);
        _;
    }
    
    //modifier ManagerContract only
    modifier managerContractOnly(){
        require(msg.sender == ManagerContract);
        _;
    }
    
    //modifier instructoronly
    modifier instructorOnly(){
        require(msg.sender == instructor);
        _;
    }
    
    
    constructor(int c, address inst, address adm) public payable {
        admin = adm;
        courseNo = c;
        instructor = inst;
        ManagerContract = msg.sender;
    }
    
    function kill() public schoolAdminOnly {
        //The admin has the right to kill the contract at any time.
        //Take care that no one else is able to kill the contract
        selfdestruct(address(uint160(admin)));
    }
    
    function enroll(int rollNo) public managerContractOnly {
        //This function can only be called by the ManagerContract
        //Enroll a student in the course if not already registered
        if(!isEnrolled[rollNo]){
            isEnrolled[rollNo] = true;
            student[rollNo] =   Marks(0,0,0);
        }
    }
    
    function markAttendance(int rollNo) public instructorOnly{
        //Only the instructor can mark the attendance
        //Increment the attendance variable by one
        //Make sure the student is enrolled in the course
        if(isEnrolled[rollNo]){
            student[rollNo].attendance += 1;
        }
    }
    
    function addMidSemMarks(int rollNo, int marks) public instructorOnly{
        //Only the instructor can add midsem marks
        //Make sure that the student is enrolled in the course
        if(isEnrolled[rollNo]){
            student[rollNo].midsem = marks;
        }
    }
    
    function addEndSemMarks(int rollNo, int marks) public instructorOnly{
        //Only the instructor can add endsem marks
        //Make sure that the student is enrolled in the course
         if(isEnrolled[rollNo]){
            student[rollNo].endsem = marks;
        }
    }
    
    function getMidsemMarks(int rollNo) public managerContractOnly view returns(int)  {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        if(isEnrolled[rollNo]){
            return student[rollNo].midsem;   
        }
    }
    
    
    function getEndsemMarks(int rollNo) public managerContractOnly view returns(int)  {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        if(isEnrolled[rollNo]){
            return student[rollNo].endsem;
        }
    }
    
    
    function getAttendance(int rollNo) public managerContractOnly view returns(int) {
        //Can only be called by the ManagerContract
        //return the midSem, endSem and attendance of the student
        //Make sure to check the student is enrolled
        if(isEnrolled[rollNo]){
            return student[rollNo].attendance;
        }
    }
    
    function isEnroll(int rollNo) public view returns(bool){
        //Returns if a roll no. is enrolled in a particular course or not
        //Can be accessed by anyone
        return isEnrolled[rollNo];
    }
    
}

