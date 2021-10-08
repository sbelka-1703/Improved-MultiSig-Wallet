pragma solidity 0.7.5;
pragma abicoder v2;


//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]

contract Wallet {
    
     constructor(address[] memory _owners, uint _limit) {
         
        owners = _owners;
        limit = _limit;
        
       
       bool duplicate = false;
       //nested loop to check for duplicate addresses 
       for(uint i = 0; i < owners.length;i++) {
         for(uint j = 0; j < owners.length;j++) {
            if(i != j) {
            if(owners[i] == owners[j]){
                duplicate = true;
             break;
        }
            }
         }
         if(duplicate){
            break;
         }
        else{
         duplicate = false;
            }
      }
          
      
      require(duplicate == false, 'Duplicate addresses entered, every address has to be unique!');
      
         
    }
    
   
    address[] public owners;
    uint limit;
    
    uint totalContractBalance = 0;
    
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
   
   
    function getBalance() public view returns(uint){
        
        return totalContractBalance / 1e18;
    }

  
    function deposit() public payable  {
        totalContractBalance = totalContractBalance + msg.value;
    }
    
   
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {
        require(_amount*1e18 <= totalContractBalance, "Insufficent balance, try lower amount");

        transferRequests.push(Transfer(_amount*1e18, _receiver, 0, false, transferRequests.length));
        
    }
    
    
    function approve(uint _id) public onlyOwners {
        require(approvals[msg.sender][_id] == false);
        require(transferRequests[_id].hasBeenSent == false);
        
 
        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;
        

        if(limit <= transferRequests[_id].approvals){
            transferRequests[_id].hasBeenSent = true;
            transferRequests[_id].receiver.transfer(transferRequests[_id].amount);
            totalContractBalance = totalContractBalance - transferRequests[_id].amount;
        }


    }
    
    function getTransferRequests() public view returns (Transfer[] memory){
       return transferRequests;

}

}