// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KYC {
    address public admin;

    struct Customer {
        string name;
        string dataHash; // Hash of KYC documents
        bool isVerified;
    }

    mapping(address => Customer) public customers;

    event CustomerAdded(address indexed customerAddress, string name);
    event CustomerVerified(address indexed customerAddress);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addCustomer(address customerAddress, string memory name, string memory dataHash) public onlyAdmin {
        customers[customerAddress] = Customer(name, dataHash, false);
        emit CustomerAdded(customerAddress, name);
    }

    function verifyCustomer(address customerAddress) public onlyAdmin {
        customers[customerAddress].isVerified = true;
        emit CustomerVerified(customerAddress);
    }

    function isCustomerVerified(address customerAddress) public view returns (bool) {
        return customers[customerAddress].isVerified;
    }
}