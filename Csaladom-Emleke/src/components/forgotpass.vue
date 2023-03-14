<template>

<div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Elfelejtette a jelszavát?</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="alert alert-success" v-if="msg=='siker'" role="alert">
          * Az új jelszót sikeresen elküldtük!
        </div>
        <div class="alert alert-danger" v-if="msg=='hiba'" role="alert">
          * Ezzel az e-mail címmel már regisztráltak!
        </div>
        <p>Ha elfelejtette jelszavát és szeretne újat, akkor adja meg a regisztrálásnál megadott e-mail címét, ebben az esetben küldünk egy új jelszót az e-mail címére</p>
        <div class="mb-3">
          <label for="exampleInputEmail1" class="form-label">Regisztrált e-mail cím</label>
          <input type="email" class="form-control"  v-model="user.email" id="exampleInputEmail1" >
        </div>
        <div class="mb-3">
          <label for="username" class="form-label">Regisztrált név</label>
          <input type="text" class="form-control"  v-model="user.name" id="username" >
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Bezárás</button>
        <button class="btn btn-primary" @click="genPassword()">Új jelszó küldése</button>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import axios from 'axios';
import sha256 from "crypto-js/sha256"

  export default{
    components:{
      axios,
      sha256
    },
    data(){
      return{
        user:{},
        msg:"",
        userId:""

      }
    },
    methods:{
      genPassword() {
        var numbers = "0123456789"
        var lowercase="abcdefghijklmnopqrstuvwxyz"
        var uppercase=lowercase.toUpperCase()

        var passwordLength = 8;
        var password = "";
        var randomNumber = Math.floor(Math.random() * uppercase.length);
        password += uppercase.substring(randomNumber, randomNumber +1);
        for (var i = 0; i <= 6; i++) {
          var randomNumber = Math.floor(Math.random() * lowercase.length);
          password += lowercase.substring(randomNumber, randomNumber +1);
        }
        var randomNumber = Math.floor(Math.random() * numbers.length);
        password += numbers.substring(randomNumber, randomNumber +1);
        
        console.log(password)
        return password;
      },
      Check(){
        axios.get(this.$store.getters.baseURL+"/forgotpass/"+this.email)
        .then(res=>{
          if (res.data.length!=0 || res.data[0].Nev==this.user.name) {
            this.userId=res.data[0].ID;
            this.SetNewPassword(res.data[0].ID)

          }else{

          }
        })
      },
      SetNewPassword(userId){
        let pw=this.genPassword();
        let felhasznalo={
          Jelszo:`${sha256(this.pw)}`
        }
        this.SendingNewPasswordInEmail(pw)
        axios.patch(this.$store.getters.baseURL+"/felhasznalok/"+this.userId,felhasznalo)
            .then(res=>{
              if (res.data.affectedRows==0) {
                this.msg='hiba'
              }else{
                this.msg='siker'
              }
              console.log(pw)
            })
      },
      SendingNewPasswordInEmail(pw){
        this.user.email
      }
    }
  }
</script>