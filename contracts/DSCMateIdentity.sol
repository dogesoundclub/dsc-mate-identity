pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/IDSCMateIdentity.sol";

contract DSCMateIdentity is IDSCMateIdentity {
    using SafeMath for uint256;

    struct Identity {
        address mates;
        uint256 mateId;
    }
    mapping(address => Identity) public identities;

    modifier onlyHolder(address mates, uint256 mateId) {
        require(IKIP17Enumerable(mates).ownerOf(mateId) == msg.sender);
        _;
    }

    function set(address mates, uint256 mateId) onlyHolder(mates, mateId) external {
        identities[msg.sender] = Identity({
            mates: mates,
            mateId: mateId
        });
    }

    function identity(address who) external returns (address mates, uint256 mateId) {
        Identity memory _identity = identities[who];
        if (_identity.mates != address(0) && IKIP17Enumerable(_identity.mates).ownerOf(mateId) == who) {
            mates = _identity.mates;
            mateId = _identity.mateId;
        }
    }
}
