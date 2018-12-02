export const FETCH_USER_DETAIL_REQUEST = 'FETCH_USER_DETAIL_REQUEST';
export const FETCH_USER_DETAIL_RESPONSE = 'FETCH_USER_DETAIL_RESPONSE';

const fetchUserDetailRequest = (userId) => ({
  type: FETCH_USER_DETAIL_REQUEST,
  userId
})

const fetchUserDetailResponse = (userId, userDetail) => ({
  type: FETCH_USER_DETAIL_RESPONSE,
  userId,
  userDetail
})

export const fetchUserDetail = (userId) => (dispatch) => {
  console.log("GETTING TO HERE")
  console.log(userId)
  dispatch(fetchUserDetailRequest(userId))
  return $.ajax({
    method: 'GET',
    url: `/users/users/${userId}`,
    dataType: 'json',
    success:(response) => {
      return dispatch(fetchUserDetailResponse(userId, response));
    }
  })
};