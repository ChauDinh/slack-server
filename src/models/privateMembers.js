export default sequelize => {
  const PrivateMembers = sequelize.define("private_member", {});

  return PrivateMembers;
};
