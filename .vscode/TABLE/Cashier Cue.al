table 50128 "Cashier Cue"
{
    Caption = 'Cashier Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Customers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'Customers';

        }
        field(3; "All Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account");
            Caption = 'All Bank Accounts';
        }
        field(4; "Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No."= FILTER('BANK-1|BANK-2|BANK-3|BANK-4|BANK-5|BANK-6|BANK-7|BANK-8|BANK-9')));
            Caption = 'Bank Accounts';
        }
        field(5; "CZK"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No."= FILTER('BANK-10|BANK-11|BANK-12|BANK-13|BANK-14|BANK-15|BANK-16|BANK-17|BANK-18')));
            Caption = 'Centri za kupce';
        }



        field(20; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Overdue Date Filter"; Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(22; "New Incoming Documents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE(Status = CONST(New)));
            Caption = 'New Incoming Documents';

        }
        field(23; "Approved Incoming Documents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE(Status = CONST(Released)));
            Caption = 'Approved Incoming Documents';

        }
        field(24; "OCR Pending"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE("OCR Status" = FILTER('Ready|Sent|Awaiting Verification')));
            Caption = 'OCR Pending';

        }


        field(27; "Requests Sent for Approval"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = FILTER('Open')));
            Caption = 'Requests Sent for Approval';

        }
        field(28; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Active Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER('Active|Inactive|On boarding'),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false)));
            Caption = 'Active Employees';

        }
        field(50001; "Inactive Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER(<> Active)));
            Caption = 'Inactive Employees';

        }
        field(50002; "Closed calculations"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Header" WHERE(Status = CONST(Closed)));
            Caption = 'Closed calculations';

        }
        field(50003; "Regular Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Contribution Category Code" = FILTER('FBIH'),
                                                Status = FILTER(Active),
                                                "For Calculation" = FILTER(true)));
            Caption = 'Regular Contracts';

        }
        field(50004; "Temporary Service Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Temporary Contract Type" = FILTER('Temporary Contract|Temporary Contract 0')));
            Caption = 'Temporary Service Contracts';

        }
        field(50005; "Temporary Service Contracts NR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Contribution Category Code" = FILTER('UODNR')));
            Caption = 'Temporary Service Contracts-Non Residents';

        }
        field(50006; "Author Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Temporary Contract Type" = FILTER('Temporary Contract Non-Residents')));
            Caption = 'Author Contracts';

        }
        field(50007; "Opened calculations"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Header" WHERE(Status = CONST(Open)));
            Caption = 'Opened calculations';

        }
        field(50008; Active; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER('Active|Inactive|On boarding'),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false)));
            Caption = 'Active Employees';

        }
        field(50009; "For Calculation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(true)));
            Caption = 'For Calculation';

        }
        field(50010; "For Calculation Witout Meal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(true),
                                                Meal = FILTER(false)));
            Caption = 'For Calculation';

        }
        field(50020; DateFilter5; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50021; "New Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER(Active),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false),
                                                "Employment Date" = FIELD(DateFilter5)));
            Caption = 'New Employees';

        }
        field(50025; DateFilter6; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50026; "New Employees FC"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter6),
                                                                  "Reason for Change" = FILTER('New Contract')));
            Caption = 'New Employees';

        }
        field(50027; "Terminated Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter7),
                                                                  "Grounds for Term. Code" = FILTER(<> '')));
            Caption = 'Terminated Employees';

        }
        field(50028; Transfers; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Reason for Change" = FILTER('Relocation'),
                                                                  Active = FILTER(true),
                                                                  "Starting Date" = FIELD(DateFilter6)));
            Caption = 'Transfers';

        }
        field(50029; "Surname Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Surname" WHERE("Last Date Modified" = FIELD(DateFilter6),
                                                          "Number Of Surnames" = FILTER(> 1),
                                                          "No." = FILTER('<> 9*')));
            Caption = 'Surname Change';

        }
        field(50030; "Adress Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Alternative Address" WHERE("Date From (CIPS)" = FIELD(DateFilter6),
                                                             Active = FILTER(true),
                                                             "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Adress Change';

        }
        field(50031; "Internal Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Internal Solidarity Fund" = FILTER(true),
                                                "Int. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'Internal Fund';

        }
        field(50032; "External Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("External Solidarity Fund" = FILTER(true),
                                                "Ext. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'External Fund';

        }
        field(50033; "Education Level Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Additional Education" WHERE(Active = FILTER(true),
                                                              "From Date" = FIELD(DateFilter6),
                                                              "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Education Level Change';

        }
        field(50034; Calculated; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Calculation Type" = FILTER(Regular),
                                                          "Date Of Calculation" = FIELD(DateFilter6)));
            Caption = 'Calculated';

        }

        field(50036; DateFilter7; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50037; DateFilter8; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50039; "Travel Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Travel Header");
            Caption = 'Travel Orders';

        }
        field(50041; "Wage Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilterChange),
                                                                  "Wage Change" = FILTER('Change Position Coefficient')));
            Caption = 'Wage Change';

        }
        field(50042; DateFilter9; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50053; "Union Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Union Employees" WHERE("Date From" = FIELD(DateFilter6)));
            Caption = 'Union Employees';

        }
        field(50054; DateFilterChange; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50055; "Negative Payment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE(Payment = FILTER(< 0)));
            Caption = 'Negative Payment';

        }
        field(50056; Additions; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Calculate Wage Addition" = FILTER(false),
                                                Status = FILTER(Active)));
            Caption = 'Active employees without wage additions';

        }
        field(50057; "Employee Disability"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Disabled Person" = FILTER(true),
                                                Status = FILTER(Active)));
            Caption = 'Employee Disability';

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

