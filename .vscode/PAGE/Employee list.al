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
            field("Send PayList"; "Send PayList")
            {

            }
            //BH 01 start
            field("Brought Years of Experience"; "Brought Years of Experience")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CurrPage.update();
                end;



                trigger OnDrillDown()
                var
                    myInt: Integer;
                begin
                    CurrPage.update();
                end;

            }
            field("Brought Months of Experience"; "Brought Months of Experience") { }
            field("Brought Days of Experience"; "Brought Days of Experience") { }
            field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.") { }
            field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.") { }
            field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.") { }
            field("Brought Years Total"; "Brought Years Total") { }
            field("Brought Months Total"; "Brought Months Total") { }
            field("Brought Days Total"; "Brought Days Total") { }
            field("Years of Experience in Company"; "Years of Experience in Company") { }
            field("Months of Exp. in Company"; "Months of Exp. in Company") { }
            field("Days of Experience in Company"; "Days of Experience in Company") { }
            field("Current Years Total"; "Current Years Total") { }
            field("Current Months Total"; "Current Months Total") { }
            field("Current Days Total"; "Current Days Total") { }
            field("Military Years of Service"; "Military Years of Service")
            {

            }
            field("Military Months of Service"; "Military Months of Service")
            {

            }
            field("Military Days of Service"; "Military Days of Service")
            { }
            field("Years of Experience"; "Years of Experience")
            {

            }
            field("Months of Experience"; "Months of Experience")
            {

            }
            field("Days of Experience"; "Days of Experience")
            {

            }
            field("Years with military"; "Years with military")
            {

            }
            field("Months with military"; "Months with military")
            {

            }
            field("Days with military"; "Days with military")
            {

            }

            //BH 01 end

        }


    }

    actions
    {
        // Add changes to page actions here

        modify(PayEmployee)
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }


        addafter("Co&mments")
        {

            //ED 01 START
            action("Base Calendar List")
            {
                Caption = 'Base Calendar List';
                Image = CalendarChanged;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BaseCalendarList.Run();
                end;
            }
            //ED 01 END

            /*action("Fill The Whole Month")
            {
                Caption = 'Fill The Whole Month';
                Image = CalendarMachine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FillTheWholeMonth.Run();
                end;
            }*/

            action("Update Work Experience")
            {
                Caption = 'Ažuriraj staž';
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

            /*action("Import Worksheet")
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
            }*/
            action("Employee Trainings Ledger")
            {
                Caption = 'Employee Training Ledger';

                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Employee Trainings Ledger";


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


        //ED 01 START       
        FillTheWholeMonth: Report "Fill The Whole Month";

        BaseCalendarList: Page "Base Calendar List";
        //ED 01 END
        //BH 01 start
        // R_MilitaryService: Report "MilitaryService";
        //BH 01 end

        XMLPortExample: XmlPort "Import sihterica";

        TimeSheetCreate: Report TimeSheet2;

        myInt: Integer;
}