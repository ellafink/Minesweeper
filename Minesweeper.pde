import de.bezier.guido.*;
public static final int NUM_ROWS = 13;
public static final int NUM_COLS = 13;
public static final int NUM_MINES = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> ();; //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //initializes the empty appartment buildings across all the floors
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    //your code to initialize buttons goes here
    for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
    }
    
    setMines();
}
public void setMines()
{
  while(mines.size() < NUM_MINES) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])) {
      mines.add(buttons[r][c]);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    int count = 0;
    for(int i = 0; i < mines.size(); i++){
       if(mines.get(i).isFlagged())
         count++;
    }
    if(count == NUM_MINES)
      return true;
    else
      return false;
}
public void displayLosingMessage()
{
    buttons[9][7].setLabel("L");
    buttons[9][8].setLabel("O");
    buttons[9][9].setLabel("S");
    buttons[9][10].setLabel("E");
    buttons[9][11].setLabel("R");
     for (int r = 0; r < NUM_ROWS; r++) {
       for (int c = 0; c < NUM_COLS; c++) {
          buttons[r][c].clicked = true;
       }
     }
    
}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("W");
    buttons[9][7].setLabel("I");
    buttons[9][8].setLabel("N");
    buttons[9][9].setLabel("N");
    buttons[9][10].setLabel("E");
    buttons[9][11].setLabel("R");
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
      return true;
    else
      return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1]))
      numMines +=1;
    if(isValid(row-1, col) && mines.contains(buttons[row-1][col]))
      numMines +=1;
    if(isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1]))
      numMines +=1;
    if(isValid(row, col-1) && mines.contains(buttons[row][col-1]))
      numMines +=1;
    if(isValid(row, col+1) && mines.contains(buttons[row][col+1]))
      numMines +=1;
    if(isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
      numMines +=1;
    if(isValid(row+1, col) && mines.contains(buttons[row+1][col]))
      numMines +=1;
    if(isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
      numMines +=1;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT && flagged == true) {
          flagged = false;
          clicked = false;
        } else if(mouseButton == RIGHT) {
          flagged = true;
        } else if(mines.contains( this )) {
          displayLosingMessage();
        } else if(countMines(myRow, myCol) > 0) {
          setLabel(countMines(myRow, myCol));
        } else {
          if(isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].isClicked()==false)
            buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow-1, myCol) && buttons[myRow-1][myCol].isClicked()==false)
            buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].isClicked()==false)
            buttons[myRow-1][myCol+1].mousePressed();
          if(isValid(myRow, myCol-1) && buttons[myRow][myCol-1].isClicked()==false)
            buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow, myCol+1) && buttons[myRow][myCol+1].isClicked()==false) 
            buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].isClicked()==false) 
            buttons[myRow+1][myCol-1].mousePressed();
          if(isValid(myRow+1, myCol) && buttons[myRow+1][myCol].isClicked()==false) 
            buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].isClicked()==false) 
            buttons[myRow+1][myCol+1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
        return clicked;
    }
}
