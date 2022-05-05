pageextension 50149 EmployeeList extends "Employee List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Old Employee No."; "Old Employee No.")

            {

            }
            field("Employee Full Name"; FullName())
            {
                Caption = 'Employee Full Name';
            }
        }
        addafter("Job Title")
        {
            field("Job Position"; "Job Position")
            {

            }
        }
        addafter("Country/Region Code")
        {
            field("Municipality Code"; "Municipality Code")
            {

            }
        }
        addafter(Comment)
        {

            field("Potential Employee"; "Potential Employee")
            {

            }
            field("Documentation delivered"; "Documentation delivered")
            {

            }
            field("Invited to interview"; "Invited to interview")
            {

            }
            field("Appropriate candidate"; "Appropriate candidate")
            {

            }
            field("Inappropriate candidate"; "Inappropriate candidate")
            {

            }
            field("Probation Period"; "Probation Period")
            {

            }
            field("Emplymt. Contract Code"; "Emplymt. Contract Code")
            {

            }
            field("Years of Experience"; "Years of Experience")
            {

            }
            field("Months of Experience"; "Months of Experience")
            {

            }
            field("Days of Experience"; "Days of Experience")
            {

            }
            field("Years of Experience in Company"; "Years of Experience in Company")
            {

            }
            field("Months of Exp. in Company"; "Months of Exp. in Company")
            {

            }
            field("Days of Experience in Company"; "Days of Experience in Company")
            {

            }
            field("Send PayList"; "Send PayList")
            {

            }
        }


    }

    actions
    {
        // Add changes to page actions here


        addafter("Co&mments")
        {



            action("Update Work Experience")
            {
                Caption = 'Update Work Experience';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    R_WorkExperience.RUN;
                    R_BroughtExperience.RUN;
                end;
            }

            action("Import Worksheet")
            {
                Caption = 'Import Worksheete';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    XMLPortExample.Run;
                end;
            }
            /*action("Create Worksheet")
            {
                Caption = 'Create Worksheet';
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TimeSheetCreate.Run;
                end;

            }*/




        }



    }

    var

        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        //BH 01 start
        // R_MilitaryService: Report "MilitaryService";
        //BH 01 end

        XMLPortExample: XmlPort "Import sihterica";

        TimeSheetCreate: Report TimeSheet2;

        myInt: Integer;
}