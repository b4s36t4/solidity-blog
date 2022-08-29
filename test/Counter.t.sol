// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/Blog.sol";

contract BlogTest is Test {
    Blog public blog;

    address internal owner;
    address internal dev;

    function setUp() public {
        blog = new Blog();
        console.log("Contact address is: ");
        emit log_address(address(blog));
        console.log("Contact Onwer is: ");
        emit log_address(blog.owner());
    }

    function testFailPostcreate() public {
        vm.prank(dev);
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        blog.createPost("https://google.com");

        console.log("Post failed cause msg.sender is not contract onwer");
    }

    // function testFailOverIndex() public {}
}
