<template>
  <div>
    <h1>This sample frontend includes</h1>
    <span>{{version}}</span>
    <span>{{test}}</span>
    <h2>Extensions</h2>
    <ul>
      <li><a href="https://github.com/cuatromedios/quasar-app-extension-vuelidate-rules" target="_blank">Vuelidate Rules</a></li>
      <li><a href="https://github.com/cuatromedios/quasar-app-extension-nequ-components" target="_blank">NeQu Components</a> (<a href="https://cuatromedios.github.io/quasar-app-extension-nequ-components/#/" target="_blank">Documentation</a>)</li>
      <li><a href="https://github.com/RobertoLangarica/quasar-app-extension-api-wrapper">Api Wrapper</a></li>
    </ul>
    <h2>Styles</h2>
    <ul>
      <li>Font changed to Open Sans</li>
      <li>Fonts for NeQu components changed to Source Code Pro 150%</li>
      <li>Other styles for NeQu Components</li>
    </ul>
  </div>
</template>

<script>
import moment from 'moment'
export default {
  name: 'PageIndex',
  data () {
    return {
      version: process.env.VERSION,
      test: moment().subtract(10, 'days').calendar()
    }
  },
  mounted () {
    console.log('Mounted')
  }
}
</script>
