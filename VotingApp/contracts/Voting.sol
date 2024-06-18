// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    address public owner;
    uint public candidatesCount;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }   

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    function getCandidate(uint _candidateId) public view returns (uint, string memory, uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.id, candidate.name, candidate.voteCount);
    }


            function getAllCandidates() public view returns (uint[] memory, string[] memory, uint[] memory) {
            uint[] memory ids = new uint[](candidatesCount);
            string[] memory names = new string[](candidatesCount);
            uint[] memory voteCounts = new uint[](candidatesCount);

            for (uint i = 1; i <= candidatesCount; i++) {
                Candidate memory candidate = candidates[i];
                ids[i - 1] = candidate.id;
                names[i - 1] = candidate.name;
                voteCounts[i - 1] = candidate.voteCount;
            }

            return (ids, names, voteCounts);
        }

    
}