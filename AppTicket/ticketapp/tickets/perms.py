from rest_framework import permissions


class IsStaffUser(permissions.BasePermission):
    def has_permission(self, request, view):
        if not request.user.is_authenticated:
            return False
        user_group_names = [g.name for g in request.user.groups.all()]
        print(user_group_names)
        return "ROLE_STAFF" in user_group_names