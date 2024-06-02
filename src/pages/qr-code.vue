<template>
  <VCard>
    <v-card-title class="title">BARCODE EQUIPMENT #{{ itemId }}  𝄃𝄃𝄂𝄂𝄀𝄁𝄃𝄂𝄂𝄃</v-card-title>
    <div class="button-container">
      <button @click="printBarcode">Imprimer le QR code</button>
    </div>
    <VTable>
      <div class="qrcode-container">
        <div class="qrcode">
          <svg id="qrcode"></svg>
        </div>
      </div>
    </VTable>
  </VCard>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { onMounted, onBeforeUnmount } from 'vue'
import JsBarcode from 'jsbarcode'

const route = useRoute();
const itemId = route.params.id;

function generateBarcode() {
  const formattedItemId = itemId.toString().padStart(8, '0');

  const screenWidth = window.innerWidth;

  let width, height, fontSize;
  if (screenWidth < 600) {
    width = 2;
    height = 80;
    fontSize = 10;
  } else if (screenWidth < 1200) {
    width = 3;
    height = 100;
    fontSize = 14;
  } else {
    width = 5;
    height = 150;
    fontSize = 20;
  }

  JsBarcode("#qrcode", formattedItemId, {
    format: "CODE128",
    displayValue: true,
    width: width,
    height: height,
    fontSize: fontSize,
  });
}

function printBarcode() {
  const printContents = document.querySelector('.qrcode-container').innerHTML;
  const originalContents = document.body.innerHTML;

  document.body.innerHTML = `<div class="print-container" style="position: absolute; top: 400px; left: 150px">${printContents}</div>`;
  window.print();
  document.body.innerHTML = originalContents;
  window.location.reload();
}

onMounted(() => {
  generateBarcode();
  window.addEventListener('resize', generateBarcode);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', generateBarcode);
});
</script>

<style scoped>
.qrcode-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 70vh;
}

.qrcode {
  text-align: center;
}

.title {
  text-align: center;
  font-size: 24px;
  margin-bottom: 20px;
  font-weight: bold;
}

.button-container {
  text-align: center;
  margin-top: 20px;
}

button {
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
}

/* Styles pour l'impression */
.print-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh; /* Hauteur complète de la page */
}
</style>
