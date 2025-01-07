// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BlogPost {
    
    struct Post {
        uint id;
        address author;
        string content;
        uint commentCount;
        uint timestamp;
    }

    struct Comment {
        uint id;
        address commenter;
        string content;
        uint timestamp;
    }

    mapping(uint => Post) public posts;
    mapping(uint => mapping(uint => Comment)) public comments; 

    event PostCreated(uint postId, address indexed author, string content, uint timestamp);
    event CommentAdded(uint postId, uint commentId, address indexed commenter, string content, uint timestamp);

    uint private nextPostId = 1; 

    function createPost(string memory _content) public {
        require(bytes(_content).length > 0, "Content cannot be empty");

        uint postId = nextPostId; 
        nextPostId++;

        posts[postId] = Post(postId, msg.sender, _content, 0, block.timestamp);

        emit PostCreated(postId, msg.sender, _content, block.timestamp);
    }

    function addComment(uint _postId, string memory _content) public {
        require(bytes(_content).length > 0, "Comment cannot be empty");
        require(posts[_postId].id > 0, "Post does not exist"); 

        Post storage post = posts[_postId];
        post.commentCount++;
        comments[_postId][post.commentCount] = Comment(post.commentCount, msg.sender, _content, block.timestamp);

        emit CommentAdded(_postId, post.commentCount, msg.sender, _content, block.timestamp);
    }

    function getPost(uint _postId) public view returns (uint, address, string memory, uint, uint) {
        require(posts[_postId].id > 0, "Post does not exist");
        Post memory post = posts[_postId];
        return (post.id, post.author, post.content, post.commentCount, post.timestamp);
    }

    function getComment(uint _postId, uint _commentId) public view returns (uint, address, string memory, uint) {
        require(posts[_postId].id > 0, "Post does not exist");
        require(_commentId > 0 && _commentId <= posts[_postId].commentCount, "Comment does not exist");

        Comment memory comment = comments[_postId][_commentId];
        return (comment.id, comment.commenter, comment.content, comment.timestamp);
    }
}
