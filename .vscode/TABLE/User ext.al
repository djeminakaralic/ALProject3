pageextension 50085 UserCard extends "User Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Windows User Name")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;

                UserSetup: Record "User Setup";
                UserRec: Record User;
                Emp: Record Employee;
            begin
                UserSetup.Reset();


                UserSetup.SetFilter("User ID", '%1', USERID);
                if UserSetup.FindFirst() then begin

                    UserSetup."New Username" := "User Name";
                    UserSetup.Modify();
                    Emp.Reset();
                    Emp.SetFilter("No.", '%1', UserSetup.UserEmp);
                    if Emp.FindFirst() then begin
                        Emp."Employee New User Name" := Rec."User Name";
                        Emp.Modify();
                    end;

                end;

            end;

        }
        modify("Authentication Email")
        {
            Visible = false;

        }
        modify("ACS Authentication")
        {
            Visible = false;
        }
        modify("Web Service Access")
        {
            Visible = false;
        }
        modify("Office 365 Authentication")
        {
            Visible = false;
        }
        modify(UserGroups)
        {
            Visible = false;
        }
        modify(Plans)
        {
            Visible = false;
        }




    }

    actions
    {
        modify(DeleteExchangeIdentifier)
        {
            Visible = false;
        }

        // Add changes to page actions here
        modify(AcsSetup)
        {
            Visible = false;
        }
        modify(ChangePassword)
        {
            Visible = false;
        }
        modify(ChangeWebServiceAccessKey)
        {
            Visible = false;
        }
        modify("Effective Permissions")
        {
            Visible = false;
        }

    }



    var
        myInt: Integer;
}