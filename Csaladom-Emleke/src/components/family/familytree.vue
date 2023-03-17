<template>
    <div id="tree" ref="tree"></div>
</template>

<style>

#tree form{
    z-index: 100;
} 

</style>

<script>

    import FamilyTree from '@balkangraph/familytree.js'
import axios from 'axios';
import router from '../../router';

    export default {
        name: 'tree',
        data(){
            return {
                family: {}
            }
        },
        methods: {
            mytree: function(domEl, x, sajat) {
                this.family = new FamilyTree (domEl, {
                    enableSearch:true,
                    searchFields: ["teljesnev", "szulido", "halido", "telefonszam"],
                    nodeTreeMenu: (sajat ? true : undefined),
                    nodes: x,
                    nodeBinding: {
                        field_0: "teljesnev",
                        field_1: "telefonszam",
                        img_0: "profilkep"
                    },
                    mode: 'light',
                    editForm: {
                        saveAndCloseBtn: "Mentés és bezárás",
                        cancelBtn: "Mégse",
                        titleBinding: "name",
                        photoBinding: "profilkep",
                        generateElementsFromFields: false,
                        addMore: false,
                        elements: [
                            [
                                {type: 'textbox', label: "Vezetéknév", binding: 'vezeteknev'},
                                {type: 'textbox', label: "Keresztnév", binding: 'keresztnev'}
                            ],
                            { type: 'textbox', label: "Telefonszám", binding: 'telefonszam'},
                            { type: 'textbox', label: "Neme", binding: 'nem'},
                            [
                                { type: 'date', label: "Születési dátum", binding: 'szulido'},
                                { type:'date', label: "Halálozási dátum", binding: 'halido'},
                            ],
                            { type: 'textbox', label: "Születési helye", binding: 'szulhely'},
                        ],
                        buttons: {
                            edit: {
                                icon: FamilyTree.icon.edit(24, 24, '#fff'),
                                text: 'Módosítás',
                                hideIfEditMode: true,
                                hideIfDetailsMode: !sajat
                            },
                            share: null,
                            pdf: null,
                            remove: {
                                icon: FamilyTree.icon.remove(24, 24, '#fff'),
                                text: 'Törlés'
                            },
                            liferoad: {
                                icon: FamilyTree.icon.ft(24, 24, '#fff'),
                                text: 'Életút',
                                hideIfEditMode: false,
                                hideIfDetailsMode: false
                            },
                            qrcode:{
                                icon: `<svg width="30" height="30" ><image href="${this.$store.getters.baseURL}/assets/qrcodeicon.png" style="width: 30px; height: 26px;" alt="" sty></svg>`,
                                text: 'QR kód',
                                hideIfEditMode: false,
                                hideIfDetailsMode: !sajat
                            }
                        }
                    }
                });
            },
            Rajzol(sajat){
                this.Magyaritas();
                this.mytree(this.$refs.tree, this.$store.getters.Members, sajat);
                if (sajat){
                    this.family.onUpdateNode((args) => {
                        
                        //Családtag törlése
                        if (args.removeNodeId != null) {
                            this.DB_Delete(args.removeNodeId);
                        }
    
                        //Új családtag rögzítése
                        args.addNodesData.forEach(item=> {
                            this.DB_Insert(item);
                        });
    
                        //Módosítás lekezelése
                        args.updateNodesData.forEach(item => {
                            item = this.Nev_Gender_Nem_Beallitas(item);
                            this.DB_Update(item);
                        });
                    });
                }

                let ez = this;
                this.family.editUI.on('button-click', function (sender, args) {
                    if (args.name == 'remove') {
                        ez.ForceDelete(ez.$store.getters.Members.find(x=> x.id == args.nodeId));
                    }
                });
                //Életút Részleg
                this.family.editUI.on('button-click', function (sender, args) {
                if (args.name == 'liferoad') {
                    let idx= ez.$store.getters.Members.find(x=> x.id == args.nodeId).ID;
                    router.push(`/eletut/${idx}`)
                }
                });
                this.family.editUI.on('button-click', function (sender, args) {
                if (args.name == 'qrcode') {
                    let idx= ez.$store.getters.Members.find(x=> x.id == args.nodeId).ID;
                    console.log("gombra rányomott");
                    ez.QRCodeGen(idx)
                }
                });
            },
            QRCodeGen(idx){
                console.log("vihar elötti csend");
                axios.post(this.$store.getters.baseURL+"/qrcode/"+idx)
                .then(res =>{
                    console.log("siker :"+res.data)
                })

            },
            ForceDelete(node){
                let children = this.GetChildren(node.id);
                if (node.mid == null && node.fid == null && (node.pids == null || node.pids.length == 0) && children.length == 1) {
                    //deleted node
                    this.DB_Delete(node.id);
                    this.$store.commit('DeleteNode', node.ID);
                    //updated node (child)
                    let child = children[0];
                    if (child.fid == node.id) {
                        child.fid = null
                    } else {
                        child.mid = null
                    }
                    this.DB_Update(child);
                    this.$store.commit('UpdateNode', child);
                    this.Rajzol(true);
                }
            },
            GetChildren(id){
                let children = []
                this.$store.getters.Members.forEach(child => {
                    if (child.mid == id ||child.fid == id) {
                        children.push(child)
                    }
                });
                return children;
            },
            DB_Delete(memberID){
                let deletedID = this.$store.getters.Members.find(x => x.id == memberID).ID
                axios.delete(this.$store.getters.baseURL + "/fileDelete/kepek/csaladtagID/" + deletedID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(res=>{
                    axios.delete(this.$store.getters.baseURL + "/kepek/csaladtagID/" + deletedID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                    .then(res=>{
                        axios.delete(this.$store.getters.baseURL + "/eletut/csaladtagID/" + deletedID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                        .then(res=>{
                            axios.delete(this.$store.getters.baseURL + "/csaladtagok/ID/" + deletedID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                            .then(res=>{

                            })
                        })
                    })

                })
            },
            DB_Insert(member){
                let partnerek = "";
                if (member.pids != null) { member.pids.forEach(partner => { partnerek += partner + ","}) }
                partnerek = partnerek.slice(0,-1);
                let inserted = {
                    csaladfaID: this.$store.getters.Members[0].csaladfaID,
                    belsofaID: member.id,
                    gender: member.gender,
                    partnerek: partnerek,
                    mid: member.mid,
                    fid: member.fid
                }
                axios.post(this.$store.getters.baseURL + "/csaladtagok", inserted, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(res => {
                    member.ID = res.data.insertId;
                    this.Nev_Gender_Nem_Beallitas(member);
                })
            },
            DB_Update(member){
                let partnerek = "";
                if (member.pids != null) { member.pids.forEach(partner => { partnerek += partner + ","}) }
                partnerek = partnerek.slice(0,-1);
                let updated = {
                    vezeteknev: member.vezeteknev,
                    keresztnev: member.keresztnev,
                    profilkep: member.profilkep,
                    telefonszam: member.telefonszam,
                    gender: member.gender,
                    szulhely: member.szulhely,
                    szulido: member.szulido,
                    halido: member.halido,
                    mid: member.mid,
                    fid: member.fid,
                    partnerek: partnerek
                }
                axios.patch(this.$store.getters.baseURL + "/csaladtagok/" + member.ID, updated, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})

            },
            Nev_Gender_Nem_Beallitas(item){
                if (item.vezeteknev == null) { item.vezeteknev = "" }
                if (item.keresztnev == null) { item.keresztnev = "" }
                item.teljesnev = item.vezeteknev + " " + item.keresztnev;



                if (item.nem != null) {
                    item.nem = item.nem.replace(/\s/g, '_');
                    if (item.nem.toLowerCase() == "férfi") {
                        item.gender = "male";
                    } else if (item.nem.toLowerCase() == "nő") {
                        item.gender = "female";
                    }
                    else {
                        item.gender = item.nem;
                    }
                }
                if (item.gender == "male") {
                    item.nem = "Férfi";
                } else if (item.gender == "female") {
                    item.nem = "Nő"
                }
                return item;
            },
            Magyaritas(){
                FamilyTree.SEARCH_HELP_SYMBOL = null;
                FamilyTree.SEARCH_PLACEHOLDER = "Keresés...";
                FamilyTree.templates.father.node=FamilyTree.templates.father.node.replace('Add father', 'Apa hozzáadása');
                FamilyTree.templates.mother.node=FamilyTree.templates.mother.node.replace('Add mother', 'Anya hozzáadása');
                FamilyTree.templates.son.node=FamilyTree.templates.son.node.replace('Add son', 'Fiú hozzáadása');
                FamilyTree.templates.daughter.node = FamilyTree.templates.daughter.node.replace('Add daughter', 'Leány hozzáadása')
                FamilyTree.templates.wife.node = FamilyTree.templates.wife.node.replace('Add wife', 'Feleség Hozzáadása');
                FamilyTree.templates.husband.node = FamilyTree.templates.husband.node.replace('Add husband', 'Férj hozzáadása');
                FamilyTree.templates.partner.node = FamilyTree.templates.partner.node.replace('Add partner', 'Partner hozzáadása');
            }

        },
    }
</script>