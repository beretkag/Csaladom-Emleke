<template>
    <div id="tree" ref="tree"></div>
</template>

<script>

    import FamilyTree from '@balkangraph/familytree.js'
import axios from 'axios';

    export default {
        name: 'tree',
        data(){
            return {
                family: {}
            }
        },
        methods: {
            mytree: function(domEl, x) {
                this.family = new FamilyTree (domEl, {
                    nodes: x,
                    nodeBinding: {
                        field_0: "teljesnev",
                        field_1: "szulido",
                        img_0: "img"
                    },
                    mode: 'light',
                    nodeTreeMenu: true,
                    editForm: {
                        titleBinding: "name",
                        photoBinding: "photo",
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
                                hideIfDetailsMode: false
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
                            }
                        }
                    }
                });
            },
            Rajzol(){
                this.mytree(this.$refs.tree, this.$store.getters.Members);

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

                
                let ez = this;
                this.family.editUI.on('button-click', function (sender, args) {
                if (args.name == 'liferoad') {
                    //alert('Életút!')
                    let member = ez.$store.getters.Members.find(x => x.id == args.nodeId);
                    console.log(member);
                }
            });
            },
            DB_Delete(memberID){
                let deletedID = this.$store.getters.Members.find(x => x.id == memberID).ID
                axios.delete(this.$store.getters.baseURL + "/csaladtagok/ID/" + deletedID);
            },
            DB_Insert(member){
                let partnerek = "";
                if (member.pids != null) { member.pids.forEach(partner => { partnerek += partner + ","}) }
                partnerek = partnerek.slice(0,-1);
                let inserted = {
                    csaladfaID: this.$store.getters.loggedUser.csaladfak.find(x => x.alapertelmezett == 0).ID,
                    belsofaID: member.id,
                    alapertelmezett: 1,
                    gender: member.gender,
                    partnerek: partnerek,
                    mid: member.mid,
                    fid: member.fid
                }
                axios.post(this.$store.getters.baseURL + "/csaladtagok", inserted)
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
                axios.patch(this.$store.getters.baseURL + "/csaladtagok/" + member.ID, updated)

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

        },
    }
</script>