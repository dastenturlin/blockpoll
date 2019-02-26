pragma solidity ^0.5.0;

/**
 * The contractName contract does this and that...
 */
contract Election {

	


	// Model a Candidate	
	struct Candidate {
		//address addr;
		uint id;
		string name;
		uint voteCount;
	}

	//mapping of all voted accounts
	mapping (address => bool) public voters;

	// Read/write Candidates: number => Candidate
	// mapping is kind of between array and hashmap
	mapping (uint => Candidate) public candidates;
	
	// Store Number of candidates - length of our mapping
	uint public candidatesCount;

	constructor () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
		//addCandidate("Candidate 3");
	}

	// add candidates to the mapping
	// function is private as we will call it only inside the contract
	function addCandidate (string memory _name) private {
		candidatesCount++;
		candidates [candidatesCount] = Candidate(candidatesCount, _name, 0);
	}	

	event votedEvent(
		uint indexed _candidateId
	);

	function vote (uint _candidateId) public {
		
		// require that they haven't voted before
		require (!voters[msg.sender]);

		// require a valid candidate
		require (_candidateId > 0 && _candidateId <= candidatesCount);
		
		// record that voter has voted
		voters[msg.sender] = true;

		// update candidate vote Count
		candidates[_candidateId].voteCount++;

		emit votedEvent(_candidateId);
	}


	
}

