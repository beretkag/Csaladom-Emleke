<template>

    <div v-if="OpenClose" class="modal d-block">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ title }}</h5>
                    <button type="button" class="btn-close" @click="OpenCloseFunction()" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>{{ text }}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" @click="OpenCloseFunction()" :class="'btn btn-' + variant">Bezárás</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
    name:'alertMSg',
    props:{
        variant: String,
    },
    data(){
        return{
            OpenClose: false,
            text: "modal message",
            title: "modal title"
        }
    },
    methods:{
        OpenCloseFunction(){
            this.OpenClose = !this.OpenClose;
        },
        SetText(text, title){
            this.text = text;
            this.title = title;
            this.OpenCloseFunction();
        }
    
    }
}

</script>