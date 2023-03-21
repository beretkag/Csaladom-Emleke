<template>
<div class="container, d-flex flex-column justify-content-center p-3">

  <div class="form-floating mb-3">
    <input type="text" class="form-control familytreeinput" id="nev" placeholder="Családfa neve" v-model="settings.Nev">
    <label for="nev" class="familytreetext">Családfa neve</label>
  </div>
  
  <table id="settings">
    <tr>
      <td>
        <h4>Publikus családfa</h4>
      </td>
      <td>
        <h5 class="mb-3">
          <div class="form-check form-switch m-2 pb-2">
            <input class="form-check-input text-center" type="checkbox" role="switch" v-model="settings.publikus">
          </div>
        </h5>
      </td>
    </tr>
    <tr>
      <td>
        <h4>Családfa sötét mód</h4>
      </td>
      <td>
        <h5 class="mb-3">
          <div class="form-check form-switch m-2 pb-2">
            <input class="form-check-input" type="checkbox" role="switch" v-model="settings.darkmode">
          </div>
        </h5>
      </td>
    </tr>

    <hr>

    <tr>
      <td>
        <h4>Férfi jelölő szín</h4>
      </td>
      <td>
        <Popper arrow>
          <button class="btn" id="ferfiszin">
            &nbsp
          </button>
          <template #content>
            <h3>Férfi:</h3>
            <ColorPicker v-if="$store.getters.Settings.darkmode != undefined"
              :color="$store.getters.Settings.ferfiszin"
              theme="light"
              :sucker-hide="true"
              @changeColor="changeMaleColor"
              :colors-default="[]"
            />
          </template>
        </Popper>
      </td>
    </tr>

    <tr>
      <td>
        <h4>Nő jelölő szín</h4>
      </td>
      <td>
        <Popper arrow>
          <button class="btn" id="noszin">
            &nbsp
          </button>
          <template #content>
            <h3>Nő:</h3>
            <ColorPicker v-if="$store.getters.Settings.darkmode != undefined"
              :color="$store.getters.Settings.noszin"
              theme="light"
              :sucker-hide="true"
              @changeColor="changeFemaleColor"
              :colors-default="[]"
            />
          </template>
        </Popper>
      </td>
    </tr>

    <tr>
      <td colspan="2">
        <div class="d-flex justify-content-around">
          <button type="button" class="btn btn-secondary" @click="Dismiss()">
          Mégse
        </button>
        <button type="button" class="btn btn-primary" @click="Save()">
          Mentés
        </button>
        </div>
      </td>
    </tr>
  </table>
</div>


</template>

<script>
  import Popper from "vue3-popper";
  import { ColorPicker } from 'vue-color-kit'
  import 'vue-color-kit/dist/vue-color-kit.css'
  import axios from 'axios';

  export default {
    components: {
      ColorPicker,
      Popper,
    },
    data() {
      return {
        settings:{},
      }
    },
    methods: {
      Save(){
        let data={
          darkmode: this.settings.darkmode ? "1" : "0",
          publikus: this.settings.publikus ? "1" : "0",
          noszin: this.settings.noszin,
          ferfiszin: this.settings.ferfiszin
        }
        axios.patch(this.$store.getters.baseURL + "/beallitasok/" + this.settings.ID, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res => {
          this.$store.commit('LoadSettings', this.settings);
        })
        if (this.settings.Nev != this.$store.getters.Settings.Nev) {
          let fa ={
            Nev: this.settings.Nev,
          }
          axios.patch(this.$store.getters.baseURL + "/csaladfak/" + this.$store.getters.Settings.csaladfaID, fa, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          .then(res => {

          })
        }
      },
      Dismiss(){
        this.settings.publikus = this.$store.getters.Settings.publikus;
        this.settings.darkmode = this.$store.getters.Settings.darkmode;
        this.settings.noszin = this.$store.getters.Settings.noszin
        this.settings.ferfiszin = this.$store.getters.Settings.ferfiszin;
        this.settings.Nev = this.$store.getters.Settings.Nev;
        
      },
      changeMaleColor(color){
        this.settings.ferfiszin = color.hex
      },
      changeFemaleColor(color){
        this.settings.noszin = color.hex
      },
    },
    watch:{
      '$store.getters.Settings' :{
        handler: function(Settings) {
          if (this.settings.darkmode == undefined) {
            this.settings={
              publikus: Settings.publikus,
              darkmode: Settings.darkmode,
              noszin: Settings.noszin,
              ferfiszin: Settings.ferfiszin,
              csaladfaID: Settings.csaladfaID,
              ID: Settings.ID,
              Nev: Settings.Nev 
            }
          }
        },
        deep: true,
      }
    }
  }

</script>

<style>


#settings td:nth-child(1){
  text-align: start;
}

#settings td:nth-child(2) *{
  line-height: 50% !important;
  vertical-align: top !important;
}

#settings td{
  padding-top: 20px !important;
}

#ferfiszin{
  background-color: v-bind('settings.ferfiszin') !important;
}

#noszin{
  background-color: v-bind('settings.noszin') !important;
}

#settings *, ::after, ::before {
    box-sizing: unset;
}

.color-alpha, .color-type{
  display: none !important;
}

.hue canvas{
  width: 230% !important;
  height: 152px;
}

.hue .slide{
  width: 230% !important;
}


</style>