<template>
    <div class="row p-3 navBar">
      <div class="col-lg-2 col-sm-12 logodiv">
        <img src="../img/logopng.png" class="logo" alt="Családomemléke logó">
      </div>
      <div class="col-lg col-sm container">
        <nav class="navbar navbar-expand-lg nav-fill w-100">
          <div class="container-fluid text-center">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
              <span> <i class="bi bi-list"></i> </span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a> Családfa szerkesztő </a>
                </li>
                <li class="nav-item" >
                  <a> Beállítások </a>
                </li>
                <li class="nav-item" >
                  <a> Elérhetőségek </a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
      </div>
    </div>
    </template>
    
<script>

</script>
    
    <style scoped>
    .logo{
      width: 12vw;
    }
    
    .navBar{
      margin: 0 0 2vh 0 !important;
    }
    
    
    button{
      border: 1px solid white !important;
    }
    
    i{
      color: white;
    }
    nav{
      margin: 2% 0 0 0 !important;
    }
    nav a{
      text-decoration: none !important;
      color: white;
      margin: auto;
      letter-spacing:0.05em;
    }
    nav a:hover{
      cursor: pointer;
    }
    li{
      text-align: center;
      display: flex;
      flex-direction: row;
      align-items: center;
      height: 3em;
    }
    li:hover a{
      color: black !important; 
    }
    li:hover{
    background-color: #ff7112;
    animation: spring 500ms ease-out;
    font-weight: bold;
    height: 3em;
    }
    nav ul{
      width: 100%;
    }
    nav ul li{
    display: flex;
    justify-content: space-around;
    }
    
    @media only screen and (max-width: 991px) {
      .navBar{
        background-color: rgb(56, 56, 56);
      }
    }
    
    @keyframes spring {
      15% {
        -webkit-transform-origin: center center;
        -webkit-transform: scale(1.2, 1.1);
      }
      40% {
        -webkit-transform-origin: center center;
        -webkit-transform: scale(0.95, 0.95);
      }
      75% {
        -webkit-transform-origin: center center;
        -webkit-transform: scale(1.05, 1);
      }
      100% {
        -webkit-transform-origin: center center;
        -webkit-transform: scale(1, 1);
      }
    }
    </style>
    