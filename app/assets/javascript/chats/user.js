
async function getUser() {
  const req  = await fetch("/get_user")
  const user = await req.json();

  if (req.ok) {
    localStorage.setItem("token", user.token)
    localStorage.setItem("userId", user.user_id)
  } else {
    alert(req.error)
  }
  
};

export { getUser }