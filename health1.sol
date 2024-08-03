// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SupplyChain {
    address private owner;

    // Product structure
    struct Product {
        uint id;
        string name;
        string provider;
        string retailer;
        bool isDistributed;
        bool isRetail;
    }

    // Mapping from product ID to Product
    mapping(uint => Product) public products;

    // Constructor sets the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Function to add a new product
    function addProduct(uint id, string memory name) public onlyOwner {
        products[id] = Product(id, name, "", "", false, false);
    }

    // Function to set the provider for a product
    function setDistributor(uint id, string memory providerName) public {
        require(!products[id].isDistributed, "Product already distributed");
        products[id].provider = providerName;
        products[id].isDistributed = true;
    }

    // Function to set the retailer for a product
    function setRetailer(uint id, string memory retailerName) public {
        require(products[id].isDistributed, "Product not distributed yet");
        require(!products[id].isRetail, "Product already retailed");
        products[id].retailer = retailerName;
        products[id].isRetail = true;
    }

    // Function to get product details
    function getProduct(uint id) public view returns (Product memory) {
        return products[id];
    }
}
