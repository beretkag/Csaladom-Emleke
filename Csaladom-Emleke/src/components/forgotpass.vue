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
          <input type="email" class="form-control"  v-model="email" id="exampleInputEmail1" aria-describedby="emailHelp">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Bezárás</button>
        <button class="btn btn-primary" @click="SendingNewPassword()">Új jelszó küldése</button>
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
        email:"",
        msg:"",
        userId:""

      }
    },
    methods:{
      genPassword() {
        var chars = "0123456789abcdefghijklmnopqrstuvwxyz!@#$%^&*()ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        var passwordLength = 8;
        var password = "";
        for (var i = 0; i <= passwordLength; i++) {
          var randomNumber = Math.floor(Math.random() * chars.length);
          password += chars.substring(randomNumber, randomNumber +1);
        }
        return password;
      },
      SendingNewPassword(){
        let pw=this.genPassword();
        let felhasznalo={
          Jelszo:`${sha256(this.pw)}`
        }
        axios.get(this.$store.getters.baseURL+"/forgotpass/"+this.email)
        .then(res=>{
          if (res.data.length!=0) {
            this.userId=res.data[0].ID;
            axios.patch(this.$store.getters.baseURL+"/felhasznalok/"+this.userId,felhasznalo)
            .then(res=>{
              if (res.data.affectedRows==0) {
                this.msg='hiba'
              }else{
                this.msg='siker'
              }
              console.log(pw)
            })
          }
        })
      }
    }
  }
</script>