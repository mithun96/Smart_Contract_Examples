pragma solidity ^0.4.0;

contract TicTacToe {

    address public owner;
    address public player;
    int[3] rows;
    int[3] cols;
    int dia; 
    int aDia;
    address playerTurn;
    int size;
    bool gameOn;
    
    int[3][3] board;
    
    // Storage variable must be public if we want automatically have a getter for it
    uint256 public state;

    event StateChanged(uint256 changedTo);
    event Error(string msg);

    function TicTacToe() public{
        owner = msg.sender;
        size = 3;
        playerTurn = owner;
    }
    
    function newGame(address player2) public returns (bool){
        player = player2;

    }
    
    function move(uint row, uint col) public returns (bool) {
        if(playerTurn != msg.sender){
            return false;
        }
        validMove(row, col);
        
        int val = 1;
        if(msg.sender == player){
            val = -1;
        }

        rows[row] += val;
        cols[col] += val;
        
        if (col == row){
            dia += val;
        }

        if (col == 3 - row - 1) {
            aDia += val;
        }
        
        checkWin(row, col);
        switchTurns();
        return true;
        
    }
    
    function switchTurns() public{
        if(playerTurn == owner){
            playerTurn = player;
        }
        else {
            playerTurn = owner;
        }
    }
    function validMove(uint row, uint col) public returns (bool){
        if(board[row][col] == 0){
            board[row][col] = 1;
            return true;
        }
        else {
            return false;
        }
    }
    
    function checkWin(uint row, uint col) public returns (bool){
        if( dia == size || dia == ((-1) * size) ||
            aDia == size || aDia == (-1) * size ||
            cols[col] == size || cols[col] == (-1) * size ||
            rows[row] == size || rows[row] == (-1) * size  ){
                //end game!!!!
                return true;
        }
        else
            return false;
    }
    

    // Function to test return value, state changes and event emission
    // function main(uint256 _newState) public returns(bool) {
    //     if (msg.sender != owner) {
    //         Error("You are not the owner");
    //         return false;
    //     }
    //     state = _newState;
    //     StateChanged(_newState);
        

    //     return true;
    // }

    // Function to test VM exception
    // function other(uint256 _newState) public returns(bool) {
    //     state = _newState;
    //     StateChanged(_newState);
    //     // Require goes after state changes in order to demonstrate changes reversion
    //     require(msg.sender != owner);
    //     return true;
    // }

}