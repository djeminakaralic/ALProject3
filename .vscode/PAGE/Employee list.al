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
        addafter("Last Name")
        {
            field("Employee ID"; "Employee ID") { }
            field("Birth Date"; "Birth Date") { }
            field(Age; Age) { }
            field(Gender; Gender) { }
            field("Org Jed"; "Org Jed") { }
            field("Department Code"; "Department Code") { }
            field("Department Category"; "Department Category") { }
            field("Department Cat. Description"; "Department Cat. Description") { }


            field(Sector; Sector) { }
            field("Sector Description"; "Sector Description") { }
            field("Department Name"; "Department Name") { }
            //field("Position Code"; "Position Code") { }
            field("Position Description"; "Position Description") { }
            field("Rad u smjenama"; "Rad u smjenama") { }
            field(Manager1; EmployeeContractLedger."Manager 1 Last Name" + ' ' + EmployeeContractLedger."Manager 1 First Name")
            {
                Caption = 'Ime i prezime prvog nadređenog';



            }
            field(Manager2; EmployeeContractLedger."Manager 2 Last Name" + ' ' + EmployeeContractLedger."Manager 2 First Name")
            {
                Caption = 'Ime i prezime drugog nadređenog';



            }




            field("Engagement Type"; "Engagement Type") { }
            field(Brutto; Brutto) { }
            field(Netto; Netto)
            {

            }
            field("Netto Total"; "Netto Total")
            {

            }
            field("Position Coefficient for Wage"; "Position Coefficient for Wage") { }
            field("Starting Date"; "Starting Date") { }
            field("Ending Date"; "Ending Date") { }
            //field("Contract type"; "Contract type") { }
            // field("Contract Termination Date"; "Contract Termination Date") { }
            field("Education Level"; "Education Level") { }
            field(Voocation; Voocation) { }
            field("Vocation Description"; "Vocation Description") { }
            field("Default Dimension"; "Default Dimension") { }
            field("Default Dimension Name"; "Default Dimension Name") { }

        }
        modify("Job Title")
        {
            Visible = false;
        }

        /*addafter("Job Title")
        {

            field("Job Position"; "Job Position")
            {

            }
        }*/
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
            field("Brought Months of Experience"; "Brought Months of Experience")
            { }
            field("Brought Days of Experience"; "Brought Days of Experience")
            { }
            field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.")
            { }
            field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.")
            { }
            field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.")
            { }
            field("Brought Years Total"; "Brought Years Total")
            { }
            field("Brought Months Total"; "Brought Months Total")
            { }
            field("Brought Days Total"; "Brought Days Total")
            { }
            field("Years of Experience in Company"; "Years of Experience in Company")
            { }
            field("Months of Exp. in Company"; "Months of Exp. in Company")
            { }
            field("Days of Experience in Company"; "Days of Experience in Company")
            { }
            field("Current Years Total"; "Current Years Total")
            { }
            field("Current Months Total"; "Current Months Total")
            { }
            field("Current Days Total"; "Current Days Total")
            { }
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
            field("Disabled Person"; "Disabled Person") { }
            field("Disability Level"; "Disability Level") { }

            field("Disabled Child"; "Disabled Child") { }
            field("Tax Deduction"; "Tax Deduction") { }
            field("Tax Deduction Amount"; "Tax Deduction Amount") { }
            field("Additional Tax"; "Additional Tax") { }
            field("Wage Posting Group"; "Wage Posting Group") { }
            // field("Employee Posting Group"; "Employee Posting Group") { }
            field("Chronic Disease"; "Chronic Disease") { }
            field(Nationallity; Nationallity)
            {
                Caption = 'Nacionalnost';
            }
            field("Passport No."; "Passport No.") { }
            field("Country/Region Code CIPS"; "Country/Region Code CIPS") { }
            field("Citizenship 1"; "Citizenship 1") { }
            field("City of Birth"; "City of Birth") { }
            field("City CIPS"; "City CIPS") { }
            field("Municipality Code CIPS"; "Municipality Code CIPS") { }
            field("Municipality Name CIPS"; "Municipality Name CIPS") { }
            field("Municipality Code of Birth"; "Municipality Code of Birth") { }
            field("Municipality Name of Birth"; "Municipality Name of Birth") { }
            field("Municipality Code for salary"; "Municipality Code for salary") { }
            field("Address CIPS"; "Address CIPS") { }
            field("Entity Code CIPS"; "Entity Code CIPS") { }
            field(Canton; Canton) { }
            //field("Phone No."; "Phone No.") { }
            field("Phone No. for Company"; "Phone No. for Company") { }
            field("Mother Maiden Name"; "Mother Maiden Name") { }
            field("Mother Name"; "Mother Name") { }
            field("Marital status"; "Marital status") { }
            field("Spouse Name"; "Spouse Name") { }
            field("Number of Children"; "Number of Children") { }
            field("Phone No. Emergency"; "Phone No. Emergency") { }
            field("Employee Computer Knowledge"; "Employee Computer Knowledge") { }
            field("Employee Qualifications"; "Employee Qualifications") { }
            field("Employee Languages"; "Employee Languages") { }
            field("Driving Licence"; "Driving Licence") { }
            field("Driving Llicence Category"; "Driving Llicence Category") { }






            //BH 01 end

        }



    }

    actions
    {
        // Add changes to page actions here
        Modify("Contact")
        {

        modify(PayEmployee)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }


        }
        
        addafter("Co&mments")
        {

            /*//ED 01 START
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

            action("Izvjestaj starosne strukture")
            {
                Caption = 'Izvjestaj starosne strukture';

                Image = Ledger;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Izvjestaj starosne strukture";


            }

            action("Evidencija prerasporedjenih")
            {
                Caption = 'Izvjestaj prerasporedjenih';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Evidencija prerasporedjenih";


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


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetCurrentKey(Order);
        Ascending;
        //EmployeeContractLedger.CalcFields("Manager 1 First Name", "Manager 2 First Name");
        SetCurrentKey(Order);






    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        Ascending;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
            EmployeeContractLedger.CALCFIELDS("Manager Department Code", "Manager 1 Position Code", "Manager Position ID", "Manager 1 First Name", "Manager 1 Last Name", "Manager 2 First Name", "Manager 1 Last Name");

        end
        ELSE BEGIN
            EmployeeContractLedger.RESET;

            EmployeeContractLedger."Manager 1 First Name" := '';
            EmployeeContractLedger."Manager 2 First Name" := '';

        END;



    end;

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
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedgerPage: page "Employee Contract Ledger";
}