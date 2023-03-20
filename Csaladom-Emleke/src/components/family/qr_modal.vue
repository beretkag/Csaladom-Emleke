<template>
    <!-- Modal -->
    <div v-if="$store.getters.QR_Modal.visible" class="modal d-block" id="qrmodal" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">{{ $store.getters.QR_Modal.node.teljesnev }} életútja</h1>
                    <button type="button" class="btn-close" @click="ModalClose()" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex flex-column align-items-center">
                    <div class="input-group mb-3">
                        <input :value="$store.getters.Domain+'/eletut/'+$store.getters.QR_Modal.node.ID" type="text" disabled class="form-control">
                        <span class="input-group-text" id="basic-addon1">
                            <button class="btn btn-secondary"><i class="bi bi-clipboard"></i></button>
                        </span>
                    </div>
                    <img :src="$store.getters.baseURL + '/img/' + $store.getters.QR_Modal.img" alt="">
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import router from '../../router';

export default{

    methods:{
        ModalClose(){
            this.$store.commit('SetQrCode', { img:'', visible:false, node:null} );
        }
    }
}


</script>
<style scoped>
img{
    width: 90vw;
    max-width: 300px;
    

}

</style>