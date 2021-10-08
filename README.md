# Improved-MultiSig-Wallet

This is an improved multisig wallet from Ivan's academy.

Improvements:
  1. Added a nested loop to check for duplicate addresses entered in the constructor   
  2. Converted wei to Ether. 
     1. The user now can input amounts in ether, not wei(1 instead of 1000000000000000000)
  3. There is now a balance function
     1. The user can get the balance of the contract and the balance
     2. The balance also updates after the funds have been withdrawn from the balance 
  4. The user is not allowed to create a transfer that is bigger than the balance of the wallet 

