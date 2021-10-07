pragma solidity 0.7.5;
pragma abicoder v2;

//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]


contract Wallet {
    
     constructor(address[] memory _owners, uint _limit) {
        owners = _owners;
        limit = _limit;
    }
    
   
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
    
    
    modifier onlyOwners(){
        bool owner = false;

        for(uint i = 0; i < owners.length; i++){
            if (owners[i] == msg.sender){
                owner = true;
            }
        }

        require(owner == true);
        _;
    }
   
   
    // function getBalance(address _address) public returns(uint){
    //     return balance(_address);
    // }

    //needs to update balance
    function deposit() public payable {
        // balance[?] + msg.value
    }
    
   
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {

        transferRequests.push(Transfer(_amount, _receiver, 0, false, transferRequests.length));
        
    }
    
    
    function approve(uint _id) public onlyOwners {
        require(approvals[msg.sender][_id] == false);
        require(transferRequests[_id].hasBeenSent == false);
 
        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;
        

        if(limit <= transferRequests[_id].approvals){
            transferRequests[_id].hasBeenSent = true;
            transferRequests[_id].receiver.transfer(transferRequests[_id].amount);
        }


    }
    
    function getTransferRequests() public view returns (Transfer[] memory){
        transferRequests;

}

}