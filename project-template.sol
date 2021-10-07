//Attempt 2
pragma solidity 0.7.5;
pragma abicoder v2;

contract Wallet {
   
    address[] public owners;
    uint limit;
    
    struct Transfer{
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }
    
    Transfer[] transferRequests;
    
    mapping(address => mapping(uint => bool)) approvals;
    mapping(address => uint) balance; 
    
    //Should only allow people in the owners list to continue the execution.
    modifier onlyOwners(){
        bool owners = false;

        for(uint i = 0; i <= owners.length; i++){
            if (owners[i] == msg.sender){
                owners = true;
            }
        }

        require(owners == true);
        _;
    }
    //Should initialize the owners list and the limit 
    constructor(address[] memory _owners, uint _limit) {
        owners = _owners;
        limit = _limit;
    }
    
    function getBalance(address _address) public returns(uint){
        return balance(_address);
    }

    //needs to update balance
    function deposit() public payable {
        // balance[?] + msg.value
    }
    
    //Create an instance of the Transfer struct and add it to the transferRequests array
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {

        transferRequests.push(Transfer(_amount, _receiver, 0, false, transferRequest.lenght));
        
    }
    
    //Set your approval for one of the transfer requests.
    //Need to update the Transfer object.
    //Need to update the mapping to record the approval for the msg.sender.
    //When the amount of approvals for a transfer has reached the limit, this function should send the transfer to the recipient.
    //An owner should not be able to vote twice.
    //An owner should not be able to vote on a tranfer request that has already been sent.
    function approve(uint _id) public onlyOwners {
        require(approvals[msg.sender][_id] == false);
        require(transferRequests[_id].hasBeenSent == false);
 
        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;
        

        if(limit <= transferRequests[_id].approvals){
            transferRequests[_id].hasBeenSent = true;
            transferRequests[_id].reciver.transfer(transferRequests[_id].amount);
        }


    }
    
    //Should return all transfer requests
    function getTransferRequests() public view returns (Transfer[] memory){
        transferRequests;

}