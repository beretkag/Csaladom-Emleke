<template>
    <div class="contacts">
        <div>
            <img src="../components/img/BeretkaGellert.jpg" alt="Beretka Gellért">
            <h1>
                Beretka Gellért
            </h1>
            <h2>
                beretkagellert@turr.hu
            </h2>
        </div>
        <div>
            <img src="../components/img/KerteszKrisztian.jpg" alt="Kertész Krisztián">
            <h1>
                Kertész Krisztián
            </h1>
            <h2>
                kerteszkrisztian@turr.hu
            </h2>
        </div>
        <div>
            <img src="../components/img/KerekAdamTamas.jpg" alt="Kerék Ádám Tamás">
            <h1>
                Kerék Ádám Tamás
            </h1>
            <h2>
                kerekadamtamas@turr.hu
            </h2>
        </div> 
    </div>
</template>
<script>
</script>
<style>
.contacts{
    margin-top: 3%;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
}
.contacts h1{
    letter-spacing: 0.1em;
    text-align: center;
    color: white;
    font-style: italic;
    text-shadow: 3px 3px 3px  black;
}
.contacts h2{
    color: white;
    font-size: 1em !important;
    text-align: center;
    font-style: italic;
}
.contacts img{
    width: 25em;
    border: 3px solid #ff7112;
    box-shadow: 50px 50px 50px 50px solid #ff7112;
}
@media(max-width: 1200px){
    .contacts{
        flex-direction: column;
        margin: auto;
        text-align: center;
    }
}
</style>