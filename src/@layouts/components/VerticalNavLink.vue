<script setup>
const props = defineProps({
  item: {
    type: null,
    required: true,
  },
})
</script>



<template>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

  <li
    class="nav-link"
    :class="{ disabled: item.disable }"
  >
    <Component
      :is="item.to ? 'RouterLink' : 'a'"
      :to="item.to"
      :href="item.href"
    >
      <!-- Choix entre VIcon et Font Awesome -->
      <template v-if="item.isFontAwesome">
        <i :class="`${item.icon}`" class="nav-item-icon text-center" style="width: 20px"></i>
      </template>
      <template v-else>
        <VIcon
          :icon="item.icon"
          class="nav-item-icon text-center"
          style="width: 20px"
        />
      </template>
      <!-- 👉 Title -->
      <span class="nav-item-title">
        {{ item.title }}
      </span>
    </Component>
  </li>
</template>


<style lang="scss">
.layout-vertical-nav {
  .nav-link a {
    display: flex;
    align-items: center;
    cursor: pointer;
  }
}
</style>
