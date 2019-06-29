<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>
      Crie seus tazos, batalhe e faça transações com seus amigos.
    </p>
    <h3>Inventário</h3>
    <ul>
      <li><a href="" target="_blank" rel="noopener">Inventário</a></li>
      <div id="txStatus"></div>
      <div id="tazos"></div>
    </ul>
    <h3>Loja</h3>
    <ul>
      <li><a href="" target="_blank" rel="noopener">Loja</a></li>
    </ul>
    <h3>Devs</h3>
    <ul>
      <li><p>Lucas Cordeiro</p></li>
      <li><p>Michel Perilo</p></li>
      <li><p>Renato Vieira</p></li>
      <li><p>Rodrigo Araújo</p></li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
