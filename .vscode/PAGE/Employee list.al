pageextension 50149 EmployeeList extends "Employee List"
{
    layout
    {
        modify("Search Name")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        // Add changes to page layout here
        addafter("No.")
        {
            field(Order; Order)
            {

            }
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
            field("Department Name"; "Department Name") { }
            field("Group Code"; "Group Code") { }
            field("Group Description"; "Group Description") { }
            field("Department Category"; "Department Category") { }
            field("Department Cat. Description"; "Department Cat. Description") { }


            field(Sector; Sector) { }
            field("Sector Description"; "Sector Description") { }

            field("Position Code"; "Position Code") { }
            field("Position Description"; "Position Description") { }
            field("Rad u smjenama"; "Rad u smjenama") { }
            field("Engagement Type"; "Engagement Type") { }
            field("Manager 1"; EmployeeContractLedger."Manager 1") { }
            field(Manager1PositionCode; EmployeeContractLedger."Manager 1 Position Code") { }
            field("Manager 1 position code"; EmployeeContractLedger."Manager 1 Position ID") { }
            field(Manager1; EmployeeContractLedger."Manager 1 Last Name" + ' ' + EmployeeContractLedger."Manager 1 First Name")
            {
                Caption = 'Ime i prezime prvog nadređenog';



            }
            field("Manager 2"; EmployeeContractLedger."Manager 2") { }
            field(Manager2PositionCode; EmployeeContractLedger."Manager 2 Position Code") { }

            field(Manager2; EmployeeContractLedger."Manager 2 Last Name" + ' ' + EmployeeContractLedger."Manager 2 First Name")
            {
                Caption = 'Ime i prezime drugog nadređenog';



            }





            field("Position Coefficient for Wage"; "Position Coefficient for Wage") { }
            field(Brutto; Brutto) { }
            field(Netto; Netto)
            {

            }
            field("Netto Total"; "Netto Total")
            {

            }


            field("Starting Date"; "Starting Date") { }
            field("Ending Date"; "Ending Date") { }
            field("Contract type"; "Contract type") { }
            field("Employement type"; EmployeeContractLedger."Engagement Type") { }
            field("First employment"; EmployeeContractLedger."First Time Employed") { }
            field("Termination"; EmployeeContractLedger."Manner of Term. Code") { }
            field("Termination name"; EmployeeContractLedger."Manner of Term. Description") { }
            field("Grounds for termination"; EmployeeContractLedger."Grounds for Term. Code") { }
            field("Grounds for term name"; EmployeeContractLedger."Grounds for Term. Description") { }
            // field("Contract Termination Date"; "Contract Termination Date") { }
            field("Education Level"; "Education Level") { }
            field("Major of Graduation"; "Major of Graduation") { }
            field("Title Code"; "Title Code") { }
            field(Title; Title) { }

            field(Voocation; Voocation) { }
            field("Vocation Description"; "Vocation Description") { }

            field(Profession; Profession)
            {

            }

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
        modify("Country/Region Code")
        {
            Caption = 'Šifra države';
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
                Visible = false;

            }
            field("Documentation delivered"; "Documentation delivered")
            {

            }
            field("Invited to interview"; "Invited to interview")
            {

            }
            field("Appropriate candidate"; "Appropriate candidate")
            {
                Visible = false;
            }
            field("Inappropriate candidate"; "Inappropriate candidate")
            {
                Visible = false;
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
            field("Bank Account Code"; "Bank Account Code") { }
            field("Bank Account No."; "Bank Account No.") { }
            field("Bank No."; "Bank No.") { }
            field("Refer To Number"; "Refer To Number") { }
            field("Hours In Day"; "Hours In Day") { }
            field("Transport Allowance"; "Transport Allowance") { }
            field("Transport Amount Planned"; "Transport Amount Planned") { }
            field("Transport Amount"; "Transport Amount") { }
            field("Wage Type"; "Wage Type") { }
            field(Meal; Meal) { }
            field("Tax Deduction"; "Tax Deduction") { }
            field("Tax Individual"; "Tax Individual") { }
            field("General Tax"; "General Tax") { }
            field("Additional Tax"; "Additional Tax") { }
            field("Tax Deduction Amount"; "Tax Deduction Amount") { }
            field("Wage Posting Group"; "Wage Posting Group") { }
            field("Contribution Category Code"; "Contribution Category Code") { }
            field("Calculate Wage Addition"; "Calculate Wage Addition") { }

            field("Disabled Person"; "Disabled Person") { }
            field("Disability Level"; "Disability Level") { }

            field("Disabled Child"; "Disabled Child") { }

            field("Chronic Disease"; "Chronic Disease") { }
            field(Nationallity; Nationallity)
            {
                Caption = 'Nacionalnost';
            }
            field("Passport No."; "Passport No.") { }

            field("Citizenship 1"; "Citizenship 1") { }
            field("City of Birth"; "City of Birth") { }
            field("Municipality Code of Birth"; "Municipality Code of Birth") { }
            field("Municipality Name of Birth"; "Municipality Name of Birth") { }
            field("Country/Region Code of Birth"; "Country/Region Code of Birth") { }
            field("Address CIPS"; "Address CIPS") { }
            field("Post Code CIPS"; "Post Code CIPS") { }

            field("City CIPS"; "City CIPS") { }

            field("Municipality Code CIPS"; "Municipality Code CIPS") { }
            field("Municipality Name CIPS"; "Municipality Name CIPS") { }
            field("Country/Region Code CIPS"; "Country/Region Code CIPS") { }

            field("Entity Code CIPS"; "Entity Code CIPS") { }


            field("Municipality Code for salary"; "Municipality Code for salary") { }
            field("Mobile Phone No. for Company"; "Mobile Phone No. for Company") { }

            //field("Phone No."; "Phone No.") { }
            field("Phone No.Company"; "Country/Region Code Company M" + ' ' + "Dial Code Company Mobile" + ' ' + "Mobile Phone No. for Company") { }
            field("Company E-Mail"; "Company E-Mail") { }
            field("Father Name"; "Father Name") { }
            field("Mother Maiden Name"; "Mother Maiden Name") { }
            field("Mother Name"; "Mother Name") { }
            field("Marital status"; "Marital status") { }
            field("Spouse Name"; "Spouse Name") { }
            field("Number of Children"; "Number of Children") { }
            field("Full Phone No."; "Full Phone No.") { }
            field("Full Mobile Phone No."; "Full Mobile Phone No.") { }
            field("Employee Computer Knowledge"; "Employee Computer Knowledge") { }
            field("Employee Qualifications"; "Employee Qualifications") { }
            field("Employee Languages"; "Employee Languages") { }
            field("Driving Licence"; "Driving Licence") { }
            field("Driving Llicence Category"; "Driving Llicence Category") { }
            field("Active Driver"; "Active Driver") { }
            field("Blood Donor"; "Blood Donor") { }
            field("Blood Type"; "Blood Type") { }


            field("Citizenship 2"; "Citizenship 2") { }
            field("Additional Passport No."; "Additional Passport No.") { }

            field("Residence Permit"; "Residence Permit") { }
            field("Residence Permit Expiry Date"; "Residence Permit Expiry Date") { }
            field("Work Permit"; "Work Permit") { }
            field("Type Of Work Permit"; "Type Of Work Permit") { }
            field("Social Security No."; "Social Security No.") { }
            field("Work Booklet No."; "Work Booklet No.") { }
            field("Work Experience Document"; "Work Experience Document") { }
            field("For Calculation"; "For Calculation") { }







            //BH 01 end

        }



    }

    actions
    {
        // Add changes to page actions here
        Modify("Contact")
        {
            Visible = false;
        }

        modify(PayEmployee)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify("Misc. Articles &Overview")
        {
            Visible = false;
        }
        modify("Mi&sc. Article Information")
        {
            Visible = false;
        }
        modify("Co&nfidential Information")
        { Visible = false; }
        modify("Con&fidential Info. Overview")
        {
            Visible = false;
        }
        /*modify(Contact)
        {
            Visible = false;
        }*/





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

            group(Izvještaji)
            {



                action("Izvjestaj starosne strukture")
                {
                    Caption = 'Izvještaj starosne strukture';

                    Image = Ledger;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj starosne strukture";


                }

                action("Izvjestaj starosna spolna")
                {
                    Caption = 'Izvještaj starosna spolna';

                    Image = Ledger;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj starosna spolna";


                }

                action("Evidencija preraspoređeni")
                {
                    Caption = 'Evidencija preraspoređeni';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Evidencija preraspoređeni";


                }
                action("Izvjestaj za trening")
                {
                    Caption = 'Izvještaj za trening';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj za_trening";


                }
                action("Uslov za penziju")
                {
                    Caption = 'Uslov za penziju';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslov za penziju";


                }
                action("Uslovi za odlazak u penziju")
                {
                    Caption = 'Uslovi za odlazak u penziju';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslovi za odlazak u penziju";


                }

                action("Uslov za penziju1")
                {
                    Caption = 'Uslov za penziju1';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslov za penziju1";


                }
                action("Uslovi za odlazak u penziju1")
                {
                    Caption = 'Uslovi za odlazak u penziju1';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslovi za odlazak u penziju1";


                }

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
        Rec.CalcFields("Position Code");

        Ascending;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
            EmployeeContractLedger.CALCFIELDS("Manager Department Code", "Manager 1 Position Code", "Manager Position ID", "Manager 1 First Name", "Manager 1 Last Name", "Manager 2 First Name", "Manager 1 Last Name", "Manager 2 Last Name");

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