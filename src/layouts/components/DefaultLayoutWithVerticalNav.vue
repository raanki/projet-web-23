<script setup>
import { ref, onMounted } from 'vue'
import { useTheme } from 'vuetify'
import VerticalNavSectionTitle from '@/@layouts/components/VerticalNavSectionTitle.vue'
import VerticalNavLayout from '@layouts/components/VerticalNavLayout.vue'
import VerticalNavLink from '@layouts/components/VerticalNavLink.vue'
import Footer from '@/layouts/components/Footer.vue'
import NavbarThemeSwitcher from '@/layouts/components/NavbarThemeSwitcher.vue'
import UserProfile from '@/layouts/components/UserProfile.vue'
import { API_URL } from '@/env'

const vuetifyTheme = useTheme()

const upgradeBanner = computed(() => {
  return vuetifyTheme.global.name.value === 'light' ? upgradeBannerLight : upgradeBannerDark
})

const searchInput = ref('')
const performSearch = async () => {
  if (searchInput.value) {
    try {
      const response = await fetch(`${API_URL}api/search?search=${searchInput.value}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      })
      if (!response.ok) {
        throw new Error('Network response was not ok')
      }
      const data = await response.json()
      console.log('Data fetched:', data)
    } catch (error) {
      console.error('Error fetching data:', error)
    }
  } else {
    console.log('Search input is empty')
  }
}

const handleKeydown = (event) => {
  if (event.key === 'Enter') {
    event.preventDefault()
    performSearch()
  }
}

onMounted(() => {
  const searchButton = document.getElementById('searchButton')
  const searchInputElement = document.getElementById('searchInput')
  searchButton.addEventListener('click', performSearch)
  searchInputElement.addEventListener('keydown', handleKeydown)
})
</script>

<template>
  <VerticalNavLayout>
    <template #navbar="{ toggleVerticalOverlayNavActive }">
      <div class="d-flex h-100 align-center">
        <div class="d-flex align-center cursor-pointer" style="user-select: none;">
          <IconBtn id="searchButton">
            <VIcon icon="bx-search"/>
          </IconBtn>
          <div class="d-flex align-center cursor-pointer" style="user-select: none;">
            <input
              id="searchInput"
              v-model="searchInput"
              class="me-3"
              type="text"
              style="width: 40vw"
              placeholder="Search"
            />
          </div>
        </div>
        <VSpacer/>
        <NavbarThemeSwitcher class="me-2"/>
        <UserProfile/>
      </div>
    </template>

    <template #vertical-nav-content>
      <VerticalNavLink
        :item="{ title: 'Dashboard', icon: 'bx-home', to: '/dashboard' }"
      />
      <VerticalNavLink
        :item="{ title: 'Equipment', icon: 'fa-solid fa-toolbox', to: '/equipment', isFontAwesome: true }"
      />
      <VerticalNavLink
        :item="{ title: 'Loan', icon: 'fa-solid fa-clipboard-list', to: '/loan', isFontAwesome: true }"
      />
      <VerticalNavLink
        :item="{ title: 'Students', icon: 'fa-solid fa-graduation-cap', to: '/student', isFontAwesome: true }"
      />
      <VerticalNavLink
        :item="{ title: 'Admin', icon: 'fa-solid fa-user', to: '/admin', isFontAwesome: true }"
      />
    </template>

    <slot/>

    <template #footer>
      <Footer/>
    </template>
  </VerticalNavLayout>
</template>

<style lang="scss" scoped>
.meta-key {
  border: thin solid rgba(var(--v-border-color), var(--v-border-opacity));
  border-radius: 6px;
  block-size: 1.5625rem;
  line-height: 1.3125rem;
  padding-block: 0.125rem;
  padding-inline: 0.25rem;
}

.search-container {
  width: 100%;
  display: flex;
  align-items: center;
}

.search-container span {
  margin-right: 1rem;
}

.search-container input[type='text'] {
  width: 100%;
  background-color: transparent;
  border: none;
  padding: 0.5rem;
}

.me-3:focus {
  outline: none;
}
</style>
