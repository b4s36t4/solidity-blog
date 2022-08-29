// SPDX-License-Identifier: PERSONAL
pragma solidity ^0.8.10;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/utils/Counters.sol";

contract Blog is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _postids;
    struct Post {
        uint id;
        uint createdAt;
        address owner;
        string contentURI;
    }

    mapping(address => Post[]) public posts;

    event PostCreated(uint id, uint createdAt, string URI);

    function getMyPosts(address me) public view returns (Post[] memory) {
        require(posts[me].length > 0, "No user posts");
        return posts[me];
    }

    function getPostByIndex(address me, uint index)
        public
        view
        returns (Post memory)
    {
        require(posts[me].length > 0, "No user posts");
        require(posts[me].length >= index, "No Post found with given index");
        return posts[me][index];
    }

    function createPost(string calldata URI) public onlyOwner {
        _postids.increment();
        uint postId = _postids.current();
        require(bytes(URI).length > 0, "Please provide URI");
        posts[msg.sender].push(Post(postId, block.timestamp, msg.sender, URI));

        emit PostCreated(postId, block.timestamp, URI);
    }
}
