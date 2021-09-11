pragma solidity ^0.5.6;

interface IDSCMateIdentity {
    
    event Set(address indexed who, address indexed mates, uint256 indexed mateId);

    function setIdentity(address mates, uint256 mateId) external;
    function identity(address who) external returns (address mates, uint256 mateId);
}
