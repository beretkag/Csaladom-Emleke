<template>
    <!-- Modal -->
    <div  class="modal d-block" id="qrmodal" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header modalheader">
                    <h1 class="modal-title fs-5">{{ $store.getters.QR_Modal.node.teljesnev }} életútja</h1>
                    <button type="button" class="btn-close" @click="ModalClose()"></button>
                </div>
                <div class="modal-body d-flex flex-column align-items-center themebg">
                    <div class="input-group mb-3 familytreeinput">
                        <input :value="$store.getters.Domain+'/eletut/'+$store.getters.QR_Modal.node.ID" type="text" class="form-control familytreeinput" disabled>
                        <span class="input-group-text familytreeinput" id="basic-addon1">
                            <button class="btn btn-secondary" @click="CopyLink($store.getters.Domain+'/eletut/'+$store.getters.QR_Modal.node.ID)"><i class="bi bi-clipboard"></i></button>
                        </span>
                    </div>
                    <img :src="$store.getters.baseURL + '/img/' + $store.getters.QR_Modal.img" alt="">
                    <div class="d-flex flex-row" id="shareButtons">
                        <ButtonFacebook text="" :url="url" isRounded hasIcon/>
                        <ButtonTwitter text="" :url="url" isRounded hasIcon/>
                        <ButtonReddit text="" :url="url" isRounded hasIcon/>
                        <ButtonLinkedIn text="" :url="url" isRounded hasIcon/>
                        <ButtonPinterest text="" :url="url" isRounded hasIcon/>
                        <ButtonWhatsapp text="" :url="url" isRounded hasIcon/>
                    </div>
                    <button  @click="Download($store.getters.QR_Modal.img)" class="btn btn-success rounded-circle"><i class="bi bi-download"></i></button>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import {ButtonFacebook, ButtonTwitter, ButtonReddit, ButtonLinkedIn, ButtonPinterest, ButtonWhatsapp} from 'share-button-links'
import axios from 'axios';


export default{
    components:{
        ButtonFacebook,
        ButtonTwitter,
        ButtonReddit, 
        ButtonLinkedIn, 
        ButtonPinterest, 
        ButtonWhatsapp
    },
    props:{
        url:String,
    },
    methods:{
        ModalClose(){
            axios.delete(this.$store.getters.baseURL + '/qrDelete/' + this.$store.getters.QR_Modal.node.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            .then(res => {
                console.log('itt');
                this.$store.commit('SetQrCode', { img:'', visible:false, node:null} );
            })
        },
        Download(picture){
          var url = '../API/Uploads/' + picture
          var tmp = document.createElement('A');
          tmp.href = url;
          tmp.download = this.$store.getters.QR_Modal.node.teljesnev+" qrcode";
          tmp.click();
        },
        CopyLink(link){
            navigator.clipboard.writeText(link);
        }
    }
}


</script>
<style scoped>
img{
    width: 90vw;
    max-width: 300px;
    image-rendering: pixelated;
}

#shareButtons a{
    height: 40px !important;
    width: 40px !important;
    padding: unset;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    margin: 5px;
    flex-wrap: wrap;
}

</style>