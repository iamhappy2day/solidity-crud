const Crud = artifacts.require("Crud");
const { assert } = require('chai');
const chai = require('chai');
const expect = chai.expect;
const BN = web3.utils.BN;

contract("Crud", accounts => {
    let crud;
    let dog;

    beforeEach ( async () => {
        crud = await Crud.deployed();
        await crud.createDog('Bob', 'Alice', 3)
        dog = await crud.getDog(1)
    })

    it("should create dog ", async () => {
    
        expect(dog.name).equal('Bob');
        expect(dog.host).equal('Alice');
        expect(Number(dog.age)).equal(3);
    });

    it('Should update dog', async () => {

        await crud.updateDog(1,'Mishka', 'Alice', 3)
        dog = await crud.getDog(1)
        expect(dog.name).equal('Mishka');
    })

    it('Should delete dog', async () => {
        try {
            await crud.deleteDog(1)
            dog = await crud.getDog(1)
        } catch(e) {
            console.log('helooooooo!!!!')
            assert(e.message.includes("There is no dog with this id"))
            return;
        }
        
        assert(false)
    })
});