var clientRoomId;
var socket = io();
var userName;
let sessionUserId = 0;

logAsAdmin();
getAllPost();
function logAsAdmin() {
    sessionUserId = 5;
    console.log(sessionUserId);
    document.getElementById('reg').style = 'display: none;';
    document.getElementById('login').style = 'display: none;';
    document.getElementById('newPosts').style = 'display: block;';
    document.getElementById('posts').style = 'display: block;';
    document.getElementById('h2reg').style = 'display: none;';
    document.getElementById('linkButton').classList.toggle("toggleDisplayNone");
}

btnReg.onclick = function () {
    var regLogin = document.getElementById('regLogin').value;
    var regName = document.getElementById('regName').value;
    var regPass = document.getElementById('regPass').value;

    if (!regLogin || !regName || !regPass) {
        document.getElementById('errMsg1').innerHTML = 'Все поля обязательные'

        return
    }
    console.log("btnReg");
    console.log(regLogin);
    console.log(regName);
    console.log(regPass);

    socket.emit("reg", regLogin, regName, regPass)
    document.getElementById('reg').style = 'display: none;';
    document.getElementById('login').style = 'display: block;';
    document.getElementById('linkButton').classList.toggle("toggleDisplayNone");
};

linkButton.onclick = function () {
    document.getElementById('reg').classList.toggle("toggleDisplayNone");
    document.getElementById('login').classList.toggle("toggleDisplayNone");

    document.getElementById('linkButton').classList.toggle("toggleDisplayNone");
};

linkButton2.onclick = function () {
    document.getElementById('reg').classList.toggle("toggleDisplayNone");
    document.getElementById('login').classList.toggle("toggleDisplayNone");

    document.getElementById('linkButton').classList.toggle("toggleDisplayNone");
};

btnLogin.onclick = function () {
    var logLogin = document.getElementById('logLogin').value;
    var logPass = document.getElementById('logPass').value;

    if (!logLogin || !logPass) {
        return
    }
    console.log("btnLogin");
    console.log(logLogin);
    console.log(logPass);

    socket.emit("login", logLogin, logPass)
    document.getElementById('reg').style = 'display: none;';
    document.getElementById('login').style = 'display: none;';
    document.getElementById('newPosts').style = 'display: block;';
    document.getElementById('h2reg').style = 'display: none;';
    document.getElementById('linkButton').style = 'display: none;';

    document.getElementById('posts').style = 'display: block;';
};

function getAllPost() {
    socket.emit("getAllPost", sessionUserId);
}

socket.on("allPost", (rows) => {
    document.getElementById('posts').innerHTML = '';
    let result = Object.values(JSON.parse(JSON.stringify(rows)));

    const posts = result.filter(post => post.parent_id == 0);
    const comments = result.filter(post => post.parent_id != 0);

    // console.log(posts);
    // console.log(comments);

    posts.forEach((v) => {
        let div = document.createElement('div');
        
        const likeClass = v.likedTypeById == 1 ? 'active-like' : '';
        const dislikeClass = v.likedTypeById == -1 ? 'active-dislike' : ''; 

        div.className = "postCard";
        div.innerHTML = 
        `
        <p>${v.name}</p>
        <p>${v.postText}</p>
        <p><small>${v.postDate.slice(0, -14)}</small></p>

        <div class="likesSection">    
                <button class="like-button like ${likeClass}" data-postid="${v.id}" data-action="like">+</button> 
                <button class="like-button dislike ${dislikeClass}"" data-postid="${v.id}" data-action="dislike">-</button> 
                <span class="likes">${v.total_likes}</span>  

                <button class="commButton">Коментировать</Button>          
        </div>
        `;

        document.getElementById('posts').append(div);
        const relatedComments = comments.filter(c => c.parent_id === v.id);
        // console.log(relatedComments);

        relatedComments.forEach((comm) => {
            const likeClass = comm.likedTypeById == 1 ? 'active-like' : '';
            const dislikeClass = comm.likedTypeById == -1 ? 'active-dislike' : ''; 

            let div2 = document.createElement('div');
            div2.className = "commCard";
            div2.innerHTML = 
            `
            <p>${comm.name}</p>
            <p>${comm.postText}</p>
            <p><small>${comm.postDate.slice(0, -14)}</small></p>

            <div class="likesSection">    
                <button class="like-button like ${likeClass}" data-postid="${comm.id}" data-action="like">+</button> 
                <button class="like-button dislike ${dislikeClass}"" data-postid="${comm.id}" data-action="dislike">-</button> 
                <span class="likes">${comm.total_likes}</span>             
            </div>
            `
            document.getElementById('posts').append(div2);
        })
    });
});

document.addEventListener('click', (e) => {
    if (e.target.classList.contains('like-button')) {
        const postId = e.target.dataset.postid;
        const action = e.target.dataset.action;
        
        console.log(`Нажата кнопка: ${action} для поста ${postId}`);
        if (action == "like"){
            socket.emit("likePost", postId, sessionUserId, 1);
        } else {
            socket.emit("likePost", postId, sessionUserId, -1);
        }
    }
});

socket.on("authorised", (id) => {
    if (id != -1) {
        sessionUserId = id;
        console.log(sessionUserId);
        document.getElementById('reg').style = 'display: none;';
        document.getElementById('login').style = 'display: none;';
        document.getElementById('newPosts').style = 'display: block;';
        document.getElementById('posts').style = 'display: block;';
        getAllPost();
    } else {
        document.getElementById('errMsg2').innerHTML = 'Неверный логин или пароль'
        document.getElementById('login').style = 'display: block;';
        document.getElementById('newPosts').style = 'display: none;';
    }

});

postText.onclick = function () {
    var nPost = document.getElementById('post').value;
    if (!nPost) {
        return;
    }
    console.log(nPost);
    socket.emit("newPost", sessionUserId, nPost);
    getAllPost();
};
socket.on("updatePost", (id) => {
    console.log("updatePost");
    getAllPost();
});



function getRandomInt(max) {
    return Math.floor(Math.random() * max);
}

function isString(val) {
    return (typeof val === "string" || val instanceof String);
}


socket.on("sendName", (p2UserName) => {
    document.getElementById('pName2').innerHTML = p2UserName;
});

socket.on("errorMessage", (txt) => {
    document.getElementById('auth').style = 'display: block;';
    document.getElementById('game').style = 'display: none;';
    document.getElementById('posts').innerHTML = txt;
});