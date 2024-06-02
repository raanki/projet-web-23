// store/index.js
import { createStore } from 'vuex'

const store = createStore({
  state: {
    user: JSON.parse(localStorage.getItem('user')) || null
  },
  getters: {
    isAuthenticated: state => !!state.user,
    getUser: state => state.user
  },
  mutations: {
    SET_USER(state, user) {
      state.user = user
      localStorage.setItem('user', JSON.stringify(user))
    },
    LOGOUT(state) {
      state.user = null
      localStorage.removeItem('user')
    }
  },
  actions: {
    login({ commit }, user) {
      commit('SET_USER', user)
    },
    logout({ commit }) {
      commit('LOGOUT')
    }
  }
})

export default store
