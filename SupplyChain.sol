// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract SupplyChain {
    
    //event Added(uint256 index);
    
    // struct State{
    //     string description;
    //     address person;
    // }
    
    struct Product{
        address creator;
        string productName;
        mapping(uint256=>string) productId;
        string date;
        string source;
        string destination;     
    }
    //Product public prod;
    mapping(uint => Product) public allProducts;
    uint256 items=0;
    uint256 counter=0;
    uint256 index;
    
    
    function concat(string memory _a, string memory _b) public returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    
    
    function newItem(string memory _id,string memory _name, string memory _date, string memory _source, string memory _destination) public returns (bool) {
        Product storage new_item = allProducts[items++];
        new_item.creator= msg.sender; 
        new_item.productId[counter++]=_id;
        new_item.productName= _name;
        new_item.date= _date;
        new_item.source= _source;
        new_item.destination= _destination;
        //emit Added(items-1);
        return true;
    }
    
    
    function searchProduct(string memory _productId) public returns (string memory) {

        for(uint256 i=0;i<counter;i++)
        {
            if(keccak256(abi.encodePacked((allProducts[i].productId[i]))) == keccak256(abi.encodePacked((_productId))))
                index= i;
                break;
        }
        require(index<=items);
        string memory output="Product Name: ";
        output=concat(output, allProducts[index].productName);
        output=concat(output, "Manufacture Date: ");
        output=concat(output, allProducts[index].date);
        output=concat(output, "Source: ");
        output=concat(output, allProducts[index].source);
        output=concat(output, "Destination: ");
        output=concat(output, allProducts[index].destination);
        
        return output;
        
    }
}
    
