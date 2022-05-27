// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Crud {

    struct Dog {
        string name;
        string host;
        uint age;
        uint id;
    }

    uint public dogId;
    Dog[] public dogs;

    function createDog(string memory _name, string memory _host, uint _age ) NonEmptyData(_name, _host) external {
        dogId++;
        dogs.push(Dog(_name, _host, _age, dogId));
    }

    function getDog(uint _id) public view returns(Dog memory) {
        Dog memory dog;
        for( uint i = 0; i < dogs.length; i++) {
            if(_id == dogs[i].id) {
                dog = dogs[i];
                return dog;
            }
        }
        revert("There is no dog with this id");
    }

    function updateDog(uint _id, string memory _name, string memory _host, uint _age) NonEmptyData(_name, _host) external {
        uint index = find(_id);
        dogs[index].age = _age;
        dogs[index].name = _name;
        dogs[index].host = _host;
    }

    function deleteDog(uint _id) external {
        uint id = find(_id);
        delete dogs[id];
    }

    function find(uint _id) internal view returns(uint) {
        for( uint i = 0; i < dogs.length; i++) {
            if(_id == dogs[i].id) {
                return i;
            }
        }
        revert("There is no dog with this id");
    }

    modifier NonEmptyData(string memory _name, string memory _host) {
        require(bytes(_name).length != 0, "Can't be empty");
        require(bytes(_host).length != 0, "Can't be empty");
        _;
    }


}