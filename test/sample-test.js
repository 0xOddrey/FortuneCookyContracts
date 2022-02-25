const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("FortuneCooky", function () {
  it("Should Deploy Both Contracts", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 1, { value: "100000000000000000000"});


    expect(await mockMinter.balanceOf(_to.address)).to.equal(1);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Should Deploy and Get New Fortune", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 1, { value: "100000000000000000000"});
    await mockMinter.connect(_to).getNewFortune(_to.address, 1);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(1);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Should Fail Insufficient Funds", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 3, { value: ethers.utils.parseEther("0.10")});
    await mockMinter.connect(_to).getNewFortune(_to.address, 1);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(0);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Should Fail Not the Owner", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 1, { value: ethers.utils.parseEther("0.10")});
    await mockMinter.connect(_to).getNewFortune(_to2.address, 1);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(0);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Should Fail Token Doesn't Exist", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 1, { value: ethers.utils.parseEther("0.10")});
    await mockMinter.connect(_to).getNewFortune(_to2.address, 1);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(0);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Should Fail Token Doesn't Exist", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(_to).mint(_to.address, 1, { value: ethers.utils.parseEther("0.10")});
    await mockMinter.connect(_to).getNewFortune(_to.address, 2);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(0);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Owner Mint Should Pass", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(owner).ownerMintTransfer(_to.address, 2);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(2);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
  it("Owner Mint Should Fail One Not Two", async function () {
   
    [
    owner,
      _to,
      _to2,
    ] = await ethers.getSigners();
    const line1 = await ethers.getContractFactory("Lines1")
    const line2 = await ethers.getContractFactory("Lines2")
    const line3 = await ethers.getContractFactory("Lines3")
    const line1D = await line1.deploy();
    const line2D = await line2.deploy();
    const line3D = await line3.deploy();
    const Builder = await ethers.getContractFactory("CookyDescriptor", {
      libraries: {
        Lines1: line1D.address,
        Lines2: line2D.address,
        Lines3: line3D.address
      },});
    mockBuilder = await Builder.deploy();
    console.log(mockBuilder.address);


    const Minter = await ethers.getContractFactory("FortuneCooky");
    mockMinter = await Minter.deploy(owner.address, mockBuilder.address);

    await mockMinter.connect(owner).ownerMintTransfer(_to.address, 1);

    expect(await mockMinter.balanceOf(_to.address)).to.equal(2);
    expect(await mockMinter.balanceOf(_to2.address)).to.equal(0);
  });
});





