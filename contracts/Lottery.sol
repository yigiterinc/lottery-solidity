pragma solidity ^0.4.17;


contract Lottery {
    address public organizer;
    address[] public participants;

    function Lottery() public {
        organizer = msg.sender;
    }

    function buyTicket() public payable {
        require(msg.value > .001 ether);

        participants.push(msg.sender);
    }

    function drawLots() public onlyOwner payable {
        require(players.length > 0);

        int winningIndex = random() % participants.length;
        address winner = participants[winningIndex];

        winner.transfer(this.balance);
        resetState();
    }

    function random() private view returns (uint) {
        return keccak256(block.blockhash(block.number - 1), now);
    }

    function resetState() private {
        players = new address[](0); // Initial length is 0
    }

    modifier onlyOwner() {
        require(msg.sender == organizer);
        _;
    }
}