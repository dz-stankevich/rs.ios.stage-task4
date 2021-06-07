import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var resultImage = image
        let targetColor = image[row][column]
        
//        **`m == image.length`**
//        **`n == image[i].length`**
//        **`1 <= m, n <= 50`**
//        **`0 <= image[i][j], newColor < 65536`**
//        **`0 <= row <= m`**
//        **`0 <= column <= n`**
        print("Entered matrix \(resultImage)")
        
        reColorImage(&resultImage, row, column, newColor, targetColor)
        
        return resultImage
    }
        
}

func reColorImage(_ image: inout [[Int]], _ row: Int, _ column: Int, _ newColor: Int, _ targetColor: Int) {
    
    print("enter func")
    
    if(row >= 0 && column >= 0 && row < image.count && column < image[0].count && image[row][column] == targetColor) {
        
        print("enter func + if")
        
        image[row][column] = newColor
        print(image)
        
        reColorImage(&image, (row + 1), column, newColor, targetColor)
        reColorImage(&image, (row - 1), column, newColor, targetColor)
        
        reColorImage(&image, row, (column + 1), newColor, targetColor)
        reColorImage(&image, row, (column - 1), newColor, targetColor)
        
    }
    else { return }
}
